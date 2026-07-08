SELECT 
    u.id,
    u.name,
    u.email, 
    u.is_active,
    u.is_super_user,
    u.is_staff,
    u.created_at,
    u.updated_at,
    up.permission_obj
FROM users u
JOIN user_profiles up ON u.id == up.user_id 
WHERE u.id == 1;