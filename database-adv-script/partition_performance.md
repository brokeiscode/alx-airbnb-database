# Partitioning Report

- Partitioning by **start_date** improved query performance for date-range queries significantly.
- Queries that previously triggered full-table sequential scans now leverage partition pruning, scanning only targeted partitions.
