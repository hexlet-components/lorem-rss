install:
	pnpm install --frozen-lockfile

start:
	npm start
lint:
	pnpm --silent run lint
	pnpm --silent run format:check
