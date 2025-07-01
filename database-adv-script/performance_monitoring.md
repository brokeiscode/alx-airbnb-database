# Performance Monitoring Report

## Tools Used

- `EXPLAIN ANALYZE` — To analyze query execution plans.
- Index creation for targeted performance improvements.

---

## Observed Bottlenecks

| Query Example                                                                                | Bottleneck Identified                                                 |
| -------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| `SELECT * FROM Booking WHERE user_id = ...`                                                  | Sequential Scan on `Booking` table due to missing index on `user_id`. |
| `SELECT * FROM Booking JOIN Property ON property_id ... WHERE name = 'Casear Project Apt 1'` | Sequential Scan on `Property` table due to missing index on `name`.   |

---

## Optimization Steps

- Added index on `user_id` in `Booking`:

```sql
CREATE INDEX Bookings_user_idx ON Booking(user_id);
```

✅ Added index on `title` in `Property`:

```sql
CREATE INDEX Properties_name_idx ON Property(name);
```

---

## Results After Optimization

| Query Example                             | Before Optimization | After Optimization   |
| ----------------------------------------- | ------------------- | -------------------- |
| Filter by `user_id` in `Booking`          | \~15.5ms, Seq Scan  | \~0.22ms, Index Scan |
| Join with `Properties` filtered by `name` | Slow, Seq Scan      | Fast, Index Scan     |

- Query times significantly reduced.\
- PostgreSQL query planner now leverages indexes efficiently.
