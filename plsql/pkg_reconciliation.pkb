create or replace package body pkg_reconciliation as

    function run(
        p_amount_tolerance in number default 0.01
    ) return number
    is
        l_run_id          number;
        l_total           number := 0;
        l_matched         number := 0;
        l_mismatch        number := 0;
        l_status          varchar2(30);
        l_details         varchar2(2000);
    begin
        insert into recon_run(status, amount_tolerance)
        values ('RUNNING', p_amount_tolerance)
        returning run_id into l_run_id;

        commit;

        for r in (
            with s as (
                select transaction_ref,
                       count(*) source_count,
                       min(transaction_date) source_date,
                       min(amount) source_amount,
                       min(currency_code) source_currency
                  from recon_source_tx
                 group by transaction_ref
            ),
            t as (
                select transaction_ref,
                       count(*) target_count,
                       min(transaction_date) target_date,
                       min(amount) target_amount,
                       min(currency_code) target_currency
                  from recon_target_tx
                 group by transaction_ref
            )
            select coalesce(s.transaction_ref, t.transaction_ref) transaction_ref,
                   nvl(s.source_count, 0) source_count,
                   nvl(t.target_count, 0) target_count,
                   s.source_date,
                   t.target_date,
                   s.source_amount,
                   t.target_amount,
                   s.source_currency,
                   t.target_currency
              from s
              full outer join t
                on t.transaction_ref = s.transaction_ref
        )
        loop
            l_total := l_total + 1;
            l_details := null;

            if r.source_count = 0 then
                l_status := 'MISSING_SOURCE';
                l_details := 'Transaction exists only in target data set';

            elsif r.target_count = 0 then
                l_status := 'MISSING_TARGET';
                l_details := 'Transaction exists only in source data set';

            elsif r.source_count > 1 then
                l_status := 'DUPLICATE_SOURCE';
                l_details := 'Source count = ' || r.source_count;

            elsif r.target_count > 1 then
                l_status := 'DUPLICATE_TARGET';
                l_details := 'Target count = ' || r.target_count;

            elsif r.source_currency <> r.target_currency then
                l_status := 'CURRENCY_MISMATCH';
                l_details := 'Source=' || r.source_currency || ', Target=' || r.target_currency;

            elsif abs(r.source_amount - r.target_amount) > p_amount_tolerance then
                l_status := 'AMOUNT_MISMATCH';
                l_details := 'Difference=' || to_char(r.source_amount - r.target_amount);

            elsif trunc(r.source_date) <> trunc(r.target_date) then
                l_status := 'DATE_MISMATCH';
                l_details := 'Source=' || to_char(r.source_date,'YYYY-MM-DD') ||
                             ', Target=' || to_char(r.target_date,'YYYY-MM-DD');

            else
                l_status := 'MATCHED';
                l_details := 'All compared attributes match';
            end if;

            insert into recon_result(
                run_id, transaction_ref, result_status, source_count, target_count,
                source_amount, target_amount, amount_difference,
                source_date, target_date, source_currency, target_currency, details
            )
            values (
                l_run_id, r.transaction_ref, l_status, r.source_count, r.target_count,
                r.source_amount, r.target_amount,
                case when r.source_amount is not null and r.target_amount is not null
                     then r.source_amount - r.target_amount end,
                r.source_date, r.target_date, r.source_currency, r.target_currency, l_details
            );

            if l_status = 'MATCHED' then
                l_matched := l_matched + 1;
            else
                l_mismatch := l_mismatch + 1;
            end if;
        end loop;

        update recon_run
           set status='COMPLETED',
               finished_at=systimestamp,
               total_results=l_total,
               matched_count=l_matched,
               mismatch_count=l_mismatch
         where run_id=l_run_id;

        commit;
        return l_run_id;

    exception
        when others then
            rollback;
            update recon_run
               set status='FAILED',
                   finished_at=systimestamp
             where run_id=l_run_id;
            commit;
            raise;
    end;

end pkg_reconciliation;
/
