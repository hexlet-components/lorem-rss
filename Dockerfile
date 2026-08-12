FROM node:26-alpine

WORKDIR /app

# corepack из образов Node 26 убран, поэтому pnpm ставится напрямую. Версия
# берётся из поля packageManager, чтобы образ и разработка совпадали.
RUN npm install -g pnpm@11.20.0

# Зависимости ставятся до копирования кода, чтобы слой с ними переиспользовался
# и не пересобирался на каждую правку исходников.
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .

EXPOSE 5000

# Раньше запуск шёл через foreman (`nf start`) по Procfile. Процесс здесь один,
# и промежуточный супервизор только прятал вывод и коды возврата.
CMD ["node", "web.js"]
