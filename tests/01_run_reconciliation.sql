set serveroutput on

declare
    l_run_id number;
begin
    l_run_id := pkg_reconciliation.run(0.01);
    dbms_output.put_line('Run ID = ' || l_run_id);
end;
/

select *
from recon_run
order by run_id desc
fetch first 1 row only;
