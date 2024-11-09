# Pin specific version for stability
# Use slim for reduced image size
FROM node:23.1-bullseye-slim AS base

# Specify working directory other than /
# This means that after this line, any commands like RUN, COPY, or CMD will be executed in the /usr/src/app directory 
# inside the container, making it the current working directory for the rest of the Dockerfile instructions.
WORKDIR /usr/src/app

# Copy only files required to install
# dependencies (better layer caching)
# Copies to /usr/src/app/package.json
COPY package*.json ./      





FROM base as dev

RUN --mount=type=cache,target=/usr/src/app/.npm \
  npm set cache /usr/src/app/.npm && \
  npm install

COPY . .

CMD ["npm", "run", "dev"]




FROM base as production
# Set NODE_ENV
ENV NODE_ENV production

# Install only production dependencies
# Use cache mount to speed up install of existing dependencies
RUN --mount=type=cache,target=/usr/src/app/.npm \
  npm set cache /usr/src/app/.npm && \
  npm ci --only=production

# Use non-root user
# Use --chown on COPY commands to set file permissions
USER node

# Copy the healthcheck script
COPY --chown=node:node ./healthcheck/ .

#This only copies:
#/healthcheck/healthcheck.js
#/src/db.js and index.js
COPY --chown=node:node ./src/ .

# Indicate expected port
EXPOSE 3000

CMD [ "node", "index.js" ]
