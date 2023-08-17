FROM okteto/okteto:2.19.0 as cli
FROM gitpod/workspace-full

COPY --from=cli /usr/local/bin/okteto /usr/local/bin/okteto