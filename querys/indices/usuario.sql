

-- dni
CREATE INDEX idx_usuario_dni
ON usuario (dni);


-- email
CREATE UNIQUE INDEX idx_usuario_email
ON usuario (email);

