create index ix_recon_source_ref on recon_source_tx(transaction_ref);
create index ix_recon_target_ref on recon_target_tx(transaction_ref);
create index ix_recon_result_run on recon_result(run_id, result_status);
