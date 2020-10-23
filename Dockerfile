FROM squidfunk/mkdocs-material:5.5.14

EXPOSE 8000

COPY . /docs

ENTRYPOINT ["/bin/sh"]

RUN apk add --no-cache curl

CMD ["-c", "mkdocs build && python -m http.server --bind 0.0.0.0 --directory site 8000"]
