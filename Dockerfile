FROM eu.gcr.io/sanity-cloud/node:10.15
MAINTAINER Kristoffer J. Sivertsen <kristoffer@sanity.io>

# Pass contents of .npmrc as --build-arg NPMRC="$(cat ~/.npmrc)".
# This is necessary for build-time access to private NPM registries
ARG NPMRC

# Set up environment
ENV APP_ROOT /src/app
WORKDIR ${APP_ROOT}

# Install app dependencies (pre-source copy in order to cache dependencies)
COPY package.json package-lock.json ./
RUN echo "$NPMRC" > ~/.npmrc && \
  npm install --no-progress --ignore-optional --loglevel=error && \
  rm ~/.npmrc

COPY . .

# Set environment
ENV NODE_ENV=production \
  SENTRY_RELEASE=$RELEASE_HASH

ENV HOST=0.0.0.0 \
  PORT=3000

# Build application
RUN npm run build

RUN chown -R app .

# Release hash (usually git commit) used for error reporting and such
ARG RELEASE_HASH

# Run application
EXPOSE 3001
CMD ["gosu", "app", "npm", "start"]
