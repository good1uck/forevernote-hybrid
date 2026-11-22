#!/bin/bash
set -euo pipefail
cd "$HOME"
rm -rf forevernote-hybrid
git clone --depth 1 https://github.com/good1uck/forevernote-hybrid.git
cd forevernote-hybrid
KEY=$(python3 -c "import re; print(re.search(r'RECAPTCHA_SITE_KEY = \"([^\"]+)\"', open('contest-prototype/index.html', encoding='utf-8').read()).group(1))")
TOKEN=$(gcloud auth print-access-token)
python3 - "$KEY" "$TOKEN" <<'PY'
import json, sys, urllib.request
key, token = sys.argv[1], sys.argv[2]
url = "https://firebaseappcheck.googleapis.com/v1/projects/42003319530/apps/1%3A42003319530%3Aweb%3A0a1894e577e3290f9c6593/recaptchaEnterpriseConfig?updateMask=siteKey"
req = urllib.request.Request(url, data=json.dumps({"siteKey": key}).encode(), method="PATCH")
req.add_header("Authorization", "Bearer " + token)
req.add_header("x-goog-user-project", "forevernote-hybrid")
req.add_header("Content-Type", "application/json")
data = json.loads(urllib.request.urlopen(req).read().decode())
print("APP_CHECK", "MATCH" if data.get("siteKey") == key else "DIFF")
PY
npx --yes firebase-tools@15.5.1 deploy --only hosting --project forevernote-hybrid --non-interactive
