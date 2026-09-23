# Design notes

This implementation reconciles aggregated representations of transaction references.

Duplicates are detected before field-level matching is trusted.

Possible production extensions include:

- configurable composite matching keys;
- fuzzy matching;
- settlement-date tolerances;
- currency conversion;
- one-to-many reconciliation;
- exception workflow and sign-off;
- business ownership;
- comments and attachments;
- SLA escalation.
