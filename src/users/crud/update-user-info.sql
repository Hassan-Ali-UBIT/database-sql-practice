UPDATE users
SET 
    name = 'admin-updated',
    is_staff = 1,
    updated_at = UNIXEPOCH()
WHERE id == 1;