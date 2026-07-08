SELECT 
    u.id, 
    u.name,
    u.email, 
    u.role,
    u.created_at,
    u.updated_at,
    up.permission_obj
FROM users u 
JOIN user_profiles up ON u.id = up.user_id
WHERE 
    u.name LIKE '%ad%' OR
    u.email LIKE '%ad%';
