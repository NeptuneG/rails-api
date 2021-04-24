# Rails Api

## Start

```bash
docker-compose up -d
```

## Swagger

http://localhost:3377/api-docs


## TODO

- [ ] Search
- [ ] Auth
- [x] Pagination
    - Cursor based pagination
- [x] Rate Limits
    - Powered by [rack/rack-attack](https://github.com/rack/rack-attack)
    - Default limit 50 requests in 30 seconds
    - If hit the throttle then reponse with header
        ```
        X-RateLimit-Limit: 50
        X-RateLimit-Remaining: 0
        X-RateLimit-Reset: 2021-04-20T08:42:30+09:00 ; Next window
        ```
    - Enable rate limits in dev env by `rails dev:cache`
- [ ] Model of Lives
    - [ ] Job for fetching lives
    - [ ] Api for jobs (trigger / status)
- [ ] Documents
- [ ] Monitoring
- [ ] Logging
- [ ] Deployment
