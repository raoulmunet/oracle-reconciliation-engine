create or replace view v_recon_latest_run as
select *
from (
    select r.*,
           row_number() over(order by run_id desc) rn
    from recon_run r
)
where rn = 1;

create or replace view v_recon_latest_summary as
select rr.result_status,
       count(*) result_count,
       sum(abs(nvl(rr.amount_difference, 0))) total_abs_difference
from recon_result rr
where rr.run_id = (select max(run_id) from recon_run)
group by rr.result_status;
