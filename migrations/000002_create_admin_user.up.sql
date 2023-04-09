with rows as (
    INSERT INTO users (
                       created_at,
                       updated_at,
                       prefix,
                       first_name,
                       last_name,
                       email,
                       password_hash)
        VALUES (now(),
                now(),
                '{admin',
                '{admin first name}',
                '{admin last name}',
                'admin@email.com',
                '{passwordhash}') returning id
)
INSERT INTO user_roles (
    created_at,
    updated_at,
    user_id,
    role)
    SELECT now(), now(), id, 1000 FROM rows;