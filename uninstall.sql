begin execute immediate 'drop package pkg_reconciliation'; exception when others then null; end;
/
begin execute immediate 'drop view v_recon_latest_summary'; exception when others then null; end;
/
begin execute immediate 'drop view v_recon_latest_run'; exception when others then null; end;
/
begin execute immediate 'drop table recon_result purge'; exception when others then null; end;
/
begin execute immediate 'drop table recon_run purge'; exception when others then null; end;
/
begin execute immediate 'drop table recon_target_tx purge'; exception when others then null; end;
/
begin execute immediate 'drop table recon_source_tx purge'; exception when others then null; end;
/
