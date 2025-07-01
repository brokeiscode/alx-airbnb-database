# Optimize Complex Queries

- Refactored the query to reduce execution time, such as using indexing and removing unnecessary columns.

## Performance Change

| Time            | Before   | After    | Cost |
| --------------- | -------- | -------- | ---- |
| Planning Time:  | 3.775 ms | 0.452 ms | 12ms |
| Execution Time: | 0.829 ms | 0.314 ms | 5ms  |
