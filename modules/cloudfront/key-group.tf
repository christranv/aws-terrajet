resource "aws_cloudfront_key_group" "documents_signing_key_group" {
  count   = var.enable_signed_url ? 1 : 0
  comment = "Includes Valid Document Signing Keys"
  items = [
    aws_cloudfront_public_key.documents_signing_key[0].id
  ]
  name = "document-keys"
}

# Convert public key to PKCS8 format (expected).
# Will take PEM, but stores internally differently
# resulting in a perma-diff
resource "aws_cloudfront_public_key" "documents_signed_urls_key" {
  count       = var.enable_signed_url ? 1 : 0
  name        = "signed-urls-key"
  comment     = "Signed URLs Key"
  encoded_key = var.signed_urls_public_key
}
