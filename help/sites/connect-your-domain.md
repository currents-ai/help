---
sidebar_position: 1
slug: /connect-your-domain
title: Connect your domain
---
# Connect your own domain to a site

Every ACME.BOT site has an address on `acme.pub`, such as `artifact-a7k2m9x1.acme.pub`. You can also serve it on a domain you own, such as `blog.example.com`. Your domain stays in your Cloudflare account. Cloudflare sends its visitors to us and gives it a free HTTPS certificate, so there's nothing to upload and no certificate to renew.

- **Time:** about 5 minutes, plus however long a new DNS record takes to go live (usually under a minute on Cloudflare)
- **You need:** a domain on Cloudflare (the free plan works) and access to its DNS settings
- **You end up with:** your site served at your own domain, with HTTPS

## Before you start

- **Your domain must use Cloudflare.** Other DNS providers aren't supported yet. If your domain is registered somewhere else, you can still add it to Cloudflare and keep it registered where it is.
- **Pick one hostname per site.** A subdomain like `blog.example.com` is the usual choice. A bare domain (`example.com`) works too. You can connect one domain to each site. To serve both `www.example.com` and `example.com`, connect one of them and redirect the other with a Redirect Rule in Cloudflare.
- **Your site keeps its `acme.pub` address.** Both addresses serve the same site, and nothing redirects from one to the other. The `acme.pub` address is always hidden from search engines, so only your own domain can show up in search results.

## Set the domain up in Cloudflare

### 1. Add a DNS record that points at ACME.BOT

In the Cloudflare dashboard, open your domain and go to **DNS** → **Records**. Click **Add record** and fill it in:

| Field | Value |
|---|---|
| **Type** | `A` |
| **Name** | The subdomain, such as `blog`. Use `@` for the bare domain. |
| **IPv4 address** | `35.190.77.59` |
| **Proxy status** | **Proxied** (the orange cloud is on) |
| **TTL** | Auto |

Click **Save**.

![Add an A record for blog, pointing at 35.190.77.59, proxied](/img/help/sites/connect-your-domain/add-dns-record.png)

:::caution
Keep the orange cloud on. With the proxy off (**DNS only**, a grey cloud), visitors reach our server directly, without Cloudflare's certificate, and the connection fails.
:::

In your list of records, the new one should show **Proxied**, like `blog` here, not **DNS only**, like `shop`:

![Proxied and DNS-only records in the Cloudflare DNS table](/img/help/sites/connect-your-domain/proxied-vs-dns-only.png)

<sub>Screenshot from the [Cloudflare docs](https://developers.cloudflare.com/dns/proxy-status/), licensed [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).</sub>

### 2. Set SSL/TLS to Full

Go to **SSL/TLS** → **Overview** and set the encryption mode to **Full**.

Don't pick **Full (strict)**. Under strict mode, Cloudflare rejects our server's certificate, because that certificate is for our domain, not yours.

![Set the SSL/TLS encryption mode to Full](/img/help/sites/connect-your-domain/ssl-tls-full.png)

If other sites on this domain need **Full (strict)**, leave the domain-wide setting alone and add a Configuration Rule instead: go to **Rules** → **Configuration Rules**, match **Hostname** equals `blog.example.com`, and set **SSL** to **Full** for that hostname only.

### 3. Check that bot protection won't block the check

When you save the domain in ACME.BOT, we send one test request to it to confirm it reaches us. Cloudflare's bot protection can block that request. It's off by default, so skip this step unless you've turned on one of these:

- **Bot Fight Mode** (**Security** → **Bots**). Turn it off while you connect the domain. Cloudflare doesn't let a rule exempt a path from Bot Fight Mode.
- **Under Attack mode** (**Overview**, under **Quick Actions**). Turn it off while you connect the domain.
- **WAF custom rules that challenge or block visitors** (**Security** → **WAF**). Add a custom rule with the action **Skip** for requests whose **URI Path** starts with `/.well-known/acme-site/`, and put it above your challenge rules.

![A WAF custom rule that skips /.well-known/acme-site/](/img/help/sites/connect-your-domain/waf-skip-rule.png)

## Connect the domain in ACME.BOT

### 4. Open the site's domain settings

In ACME.BOT, click **Sites** in the left sidebar, then open the **Domains** tab. Each of your sites has its own card.

### 5. Enter your domain and save

In the site's card, type your domain into **Your Domain**, such as `blog.example.com`. Type only the hostname: leave out `https://`, any path, and any port. Click **Save**.

ACME.BOT checks the domain right away. If the check passes, the domain is connected and the site's link in the dashboard changes to it. If it fails, nothing is saved, and the message names the fix. See [If the check fails](#if-the-check-fails).

### 6. Visit your domain

Open `https://blog.example.com`. You should see your site. If you turned off bot protection in step 3, you can turn it back on now.

## If the check fails

| Message | What to do |
|---|---|
| We couldn't find a DNS record for this domain. | The `A` record from step 1 is missing, or it isn't live yet. Check the name, wait a minute and save again. |
| This domain points at us directly. | The record is **DNS only**. Turn on the orange cloud (step 1). |
| Cloudflare is checking our certificate strictly. | The SSL/TLS mode is **Full (strict)**. Set it to **Full** for this hostname (step 2). |
| Cloudflare's bot protection blocked our check. | Turn off Bot Fight Mode or Under Attack mode, or skip `/.well-known/acme-site/*` in your WAF rules (step 3). |
| Cloudflare couldn't reach our servers. | The `A` record points at the wrong address. Set it to `35.190.77.59`. |
| This domain doesn't reach our servers. | The record is missing, wrong, or not proxied, or the domain isn't on Cloudflare. Recheck steps 1 and 2. If you've only just added the domain to Cloudflare, wait a few minutes for its certificate and try again. |
| That domain is connected to another of your sites. | Clear it on that site first (see below), then add it here. |
| That domain is already in use. | Another account has connected this domain. If it's yours, contact support. |

## Change or disconnect a domain

- **Change it:** type the new domain and click **Save**. The new domain replaces the old one only once it passes the check.
- **Disconnect it:** clear the field and click **Save**. The site's link goes back to its `acme.pub` address.

In both cases, **delete the old domain's DNS record in Cloudflare.** A record left pointing at us lets someone else connect that domain to their own site. The message after you save reminds you.

Deleting a site doesn't free its domain. The domain stays reserved for your account, and you can connect it to another of your sites later.

If your DNS stops pointing at us later, only your domain stops working. The site's `acme.pub` address keeps serving.
