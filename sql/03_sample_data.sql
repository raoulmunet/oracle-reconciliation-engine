insert into recon_source_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1001', date '2026-09-01', 100.00, 'EUR', 'ACC001');

insert into recon_target_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1001', date '2026-09-01', 100.00, 'EUR', 'ACC001');

insert into recon_source_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1002', date '2026-09-01', 1250.00, 'EUR', 'ACC002');

insert into recon_target_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1002', date '2026-09-01', 1200.00, 'EUR', 'ACC002');

insert into recon_source_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1003', date '2026-09-02', 50.00, 'EUR', 'ACC003');

insert into recon_target_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1004', date '2026-09-03', 75.00, 'EUR', 'ACC004');

insert into recon_source_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1005', date '2026-09-04', 99.00, 'EUR', 'ACC005');

insert into recon_target_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1005', date '2026-09-05', 99.00, 'EUR', 'ACC005');

insert into recon_source_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1006', date '2026-09-06', 10.00, 'EUR', 'ACC006');

insert into recon_source_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1006', date '2026-09-06', 10.00, 'EUR', 'ACC006');

insert into recon_target_tx(transaction_ref, transaction_date, amount, currency_code, account_ref)
values ('TX1006', date '2026-09-06', 10.00, 'EUR', 'ACC006');

commit;
