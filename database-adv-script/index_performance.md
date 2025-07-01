# Indexes for Optimization

## Index Created to improve performance

- Bookings(user_id);
- Reviews(property_id);
- Bookings(start_date);
- Properties(name, country, host_id);

EXPLAIN ANALYZE SELECT \* FROM bookings AS b
INNER JOIN users AS u ON b.user_id = u.user_id ORDER BY b.start_date DESC;
| Time | Before | After |
|--------------|-------------------|
|Planning Time: | 1.456 ms | 1.152 ms |
|Execution Time: | 0.376 ms | 0.193 ms |

EXPLAIN ANALYZE SELECT \* FROM properties AS p
LEFT JOIN reviews AS r ON p.property_id = r.property_id ORDER BY p.name ASC;
| Time | Before | After |
|--------------|-------------------|
|Planning Time: | 1.144 ms | 2.039 ms |
|Execution Time: | 2.490 ms | 0.220 ms |

EXPLAIN ANALYZE SELECT \* FROM properties WHERE country = 'Nigeria';
| Time | Before | After |
|--------------|-------------------|
|Planning Time: | 0.178 ms | 0.196 ms |
|Execution Time: | 0.106 ms | 0.092 ms |
