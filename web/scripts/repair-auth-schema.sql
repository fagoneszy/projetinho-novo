ALTER TABLE users
  ADD COLUMN IF NOT EXISTS avatar_url TEXT,
  ADD COLUMN IF NOT EXISTS bio TEXT,
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT now();

UPDATE users
SET updated_at = COALESCE(updated_at, created_at, now())
WHERE updated_at IS NULL;

ALTER TABLE users
  ALTER COLUMN updated_at SET DEFAULT now(),
  ALTER COLUMN updated_at SET NOT NULL;

CREATE TABLE IF NOT EXISTS sessions (
  id SERIAL PRIMARY KEY,
  token_hash TEXT NOT NULL UNIQUE,
  user_id INTEGER NOT NULL REFERENCES users(id),
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT now() NOT NULL,
  last_seen_at TIMESTAMP DEFAULT now() NOT NULL
);
