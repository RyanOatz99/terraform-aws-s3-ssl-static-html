# SSL S3 Static HTML Hosting

This terraform module is used to deploy the resources needed to create a static website behind SSL/TLS

Example:

``` hcl

```

This module does not upload any content to the bucket.

There are several important details requiring attention

* This module expects that you already have a SSL/TLS Certificate managed by ACM and will capture it via the "certificate_domain" variable
* The index/404 pages names are hard-coded, "index.html" and "404.html"
* This module expects that you already have a hosted zone and will try to capture is via the supplied FQDD
