select *
from v_recon_latest_summary
order by result_status;

select transaction_ref,
       result_status,
       source_count,
       target_count,
       source_amount,
       target_amount,
       amount_difference,
       source_date,
       target_date,
       details
from recon_result
where run_id = (select max(run_id) from recon_run)
order by transaction_ref;
