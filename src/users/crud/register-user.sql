BEGIN TRANSACTION;
INSERT INTO 
    users(name, email, password, is_active, is_super_user, is_staff, created_at, updated_at) 
    VALUES('jaddah', 'jaddah@yopmail.com', '1234', 1, 1, 1, UNIXEPOCH(), UNIXEPOCH());

INSERT INTO
    user_profiles(user_id, permission_obj, created_at, updated_at)
    VALUES (LAST_INSERT_ROWID(), '{"user": {"read": true, "write": true}}', UNIXEPOCH(), UNIXEPOCH());
COMMIT;
