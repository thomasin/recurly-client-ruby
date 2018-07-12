module Recurly
  class Client

    def api_version
      "v2018-01-24"
    end

    # List sites
    #
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @return [Pager<Resources::Site>] A list of sites.
    def list_sites(**options)
      site_id = validate_site_id!(site_id)
      path = "/sites"
      pager(path, **options)
    end

    # Fetch a site
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @return [Resources::Site] A site.
    def get_site(site_id: nil)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}", site_id: site_id)
      get(path)
    end

    # List a site's accounts
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param subscriber [String] Filter accounts accounts with or without a subscription in the `active`, `canceled`, or `future` state.
    # @param past_due [String] Filter for accounts with an invoice in the `past_due` state.
    # @return [Pager<Resources::Account>] A list of the site's accounts.
    def list_accounts(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts", site_id: site_id)
      pager(path, **options)
    end

    # Create an account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param body [Requests::CreateAccount] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CreateAccount}.
    # @return [Resources::Account] An account.
    def create_account(site_id: nil, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts", site_id: site_id)
      post(path, body, Requests::CreateAccount)
    end

    # Fetch an account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @return [Resources::Account] An account.
    # @example
    #   begin
    #     # You can use the `id` field from an Account object
    #     account = @client.get_account(account_id: "hympfmab60ic")
    #     # If you only have the account code, you can prefix with `code-`
    #     account = @client.get_account(account_id: "code-benjamin.dumonde@example.com")
    #   rescue Recurly::Errors::NotFoundError => e
    #     puts e
    #     # => Recurly::NotFoundError: Couldn't find Account with code = benjamin.dumonde@example.com
    #     puts e.recurly_error
    #     # => #<Recurly::Error:0x007f8b29918618 @attributes={:type=>"not_found", :message=>"Couldn't find Account with code = benjamin.dumonde@example.com", :params=>[{"param"=>"account_id"}]}>
    #   end
    #
    def get_account(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Modify an account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param body [Requests::AccountUpdatable] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountUpdatable}.
    # @return [Resources::Account] An account.
    def update_account(site_id: nil, account_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      put(path, body, Requests::AccountUpdatable)
    end

    # Deactivate an account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @return [Resources::Account] An account.
    def deactivate_account(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Fetch an account's acquisition data
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @return [Resources::AccountAcquisition] An account's acquisition data.
    def get_account_acquisition(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/acquisition", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Update an account's acquisition data
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param body [Requests::AccountAcquisitionUpdatable] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AccountAcquisitionUpdatable}.
    # @return [Resources::AccountAcquisition] An account's updated acquisition data.
    def update_account_acquisition(site_id: nil, account_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/acquisition", site_id: site_id, account_id: account_id)
      put(path, body, Requests::AccountAcquisitionUpdatable)
    end

    # Remove an account's acquisition data
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    def remove_account_acquisition(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/acquisition", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Reactivate an inactive account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @return [Resources::Account] An account.
    def reactivate_account(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/reactivate", site_id: site_id, account_id: account_id)
      put(path)
    end

    # Fetch an account's balance and past due status
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @return [Resources::AccountBalance] An account's balance.
    def get_account_balance(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/balance", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Fetch an account's billing information
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @return [Resources::BillingInfo] An account's billing information.
    def get_billing_info(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Set an account's billing information
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param body [Requests::BillingInfoCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::BillingInfoCreate}.
    # @return [Resources::BillingInfo] Updated billing information.
    def update_billing_info(site_id: nil, account_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      put(path, body, Requests::BillingInfoCreate)
    end

    # Remove an account's billing information
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    def remove_billing_info(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/billing_info", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # Show the coupon redemptions for an account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions on an account.
    def list_account_coupon_redemptions(site_id: nil, account_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Show the coupon redemption that is active on an account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @return [Resources::CouponRedemption] An active coupon redemption on an account.
    def get_active_coupon_redemption(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      get(path)
    end

    # Generate an active coupon redemption on an account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param body [Requests::CreateCouponRedemption] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CreateCouponRedemption}.
    # @return [Resources::CouponRedemption] Returns the new coupon redemption.
    def create_coupon_redemption(site_id: nil, account_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      post(path, body, Requests::CreateCouponRedemption)
    end

    # Delete the active coupon redemption from an account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @return [Resources::CouponRedemption] Coupon redemption deleted.
    def remove_coupon_redemption(site_id: nil, account_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/coupon_redemptions/active", site_id: site_id, account_id: account_id)
      delete(path)
    end

    # List an account's credit payments
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @return [Pager<Resources::CreditPayment>] A list of the account's credit payments.
    def list_account_credit_payments(site_id: nil, account_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/credit_payments", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List an account's invoices
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param type [String] Filter by type when: - `type=charge`, only charge invoices will be returned. - `type=credit`, only credit invoices will be returned. - `type=non-legacy`, only charge and credit invoices will be returned. - `type=legacy`, only legacy invoices will be returned.
    # @return [Pager<Resources::Invoice>] A list of the account's invoices.
    def list_account_invoices(site_id: nil, account_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create an invoice for pending line items
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}.
    # @return [Resources::InvoiceCollection] Returns the new invoices.
    def create_invoice(site_id: nil, account_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices", site_id: site_id, account_id: account_id)
      post(path, body, Requests::InvoiceCreate)
    end

    # Preview new invoice for pending line items
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param body [Requests::InvoiceCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceCreate}.
    # @return [Resources::InvoiceCollection] Returns the invoice previews.
    def preview_invoice(site_id: nil, account_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/invoices/preview", site_id: site_id, account_id: account_id)
      post(path, body, Requests::InvoiceCreate)
    end

    # List an account's line items
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param original [String] Filter by original field.
    # @param state [String] Filter by state field.
    # @param type [String] Filter by type field.
    # @return [Pager<Resources::LineItem>] A list of the account's line items.
    def list_account_line_items(site_id: nil, account_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/line_items", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create a new line item for the account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param body [Requests::LineItemCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::LineItemCreate}.
    # @return [Resources::LineItem] Returns the new line item.
    def create_line_item(site_id: nil, account_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/line_items", site_id: site_id, account_id: account_id)
      post(path, body, Requests::LineItemCreate)
    end

    # Fetch a list of an account's notes
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @return [Pager<Resources::AccountNote>] A list of an account's notes.
    def list_account_notes(site_id: nil, account_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/notes", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Fetch an account note
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param account_note_id [String] Account Note ID.
    # @return [Resources::AccountNote] An account note.
    def get_account_note(site_id: nil, account_id:, account_note_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/notes/{account_note_id}", site_id: site_id, account_id: account_id, account_note_id: account_note_id)
      get(path)
    end

    # Fetch a list of an account's shipping addresses
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @return [Pager<Resources::ShippingAddress>] A list of an account's shipping addresses.
    def list_shipping_addresses(site_id: nil, account_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # Create a new shipping address for the account
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param body [Requests::ShippingAddressCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressCreate}.
    # @return [Resources::ShippingAddress] Returns the new shipping address.
    def create_shipping_address(site_id: nil, account_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses", site_id: site_id, account_id: account_id)
      post(path, body, Requests::ShippingAddressCreate)
    end

    # Fetch an account's shipping address
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param shipping_address_id [String] Shipping Address ID.
    # @return [Resources::ShippingAddress] A shipping address.
    def get_shipping_address(site_id: nil, account_id:, shipping_address_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      get(path)
    end

    # Update an account's shipping address
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param shipping_address_id [String] Shipping Address ID.
    # @param body [Requests::ShippingAddressUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::ShippingAddressUpdate}.
    # @return [Resources::ShippingAddress] The updated shipping address.
    def update_shipping_address(site_id: nil, account_id:, shipping_address_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      put(path, body, Requests::ShippingAddressUpdate)
    end

    # Remove an account's shipping address
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param shipping_address_id [String] Shipping Address ID.
    def remove_shipping_address(site_id: nil, account_id:, shipping_address_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/shipping_addresses/{shipping_address_id}", site_id: site_id, account_id: account_id, shipping_address_id: shipping_address_id)
      delete(path)
    end

    # List an account's subscriptions
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param state [String] Filter by state. - When `state=active`, `state=canceled`, `state=expired`, or `state=future`, subscriptions with states that match the query and only those subscriptions will be returned. - When `state=in_trial`, only subscriptions that have a trial_started_at date earlier than now and a trial_ends_at date later than now will be returned. - When `state=live`, only subscriptions that are in an active, canceled, or future state or are in trial will be returned.
    # @return [Pager<Resources::Subscription>] A list of the account's subscriptions.
    def list_account_subscriptions(site_id: nil, account_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/subscriptions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List an account's transactions
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param account_id [String] Account ID or code (use prefix: `code-`, e.g. `code-bob`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param type [String] Filter by type field.
    # @param success [String] Filter by success field.
    # @return [Pager<Resources::Transaction>] A list of the account's transactions.
    def list_account_transactions(site_id: nil, account_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/accounts/{account_id}/transactions", site_id: site_id, account_id: account_id)
      pager(path, **options)
    end

    # List a site's account acquisition data
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @return [Resources::AccountAcquisition] A list of the site's account acquisition data.
    def list_account_acquisition(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/acquisitions", site_id: site_id)
      get(path, **options)
    end

    # List a site's coupons
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @return [Pager<Resources::Coupon>] A list of the site's coupons.
    def list_coupons(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/coupons", site_id: site_id)
      pager(path, **options)
    end

    # Create a new coupon
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param body [Requests::CreateCoupon] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::CreateCoupon}.
    # @return [Resources::Coupon] A new coupon.
    def create_coupon(site_id: nil, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/coupons", site_id: site_id)
      post(path, body, Requests::CreateCoupon)
    end

    # Fetch a coupon
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param coupon_id [String] Coupon ID or code (use prefix: `code-`, e.g. `code-10off`).
    # @return [Resources::Coupon] A coupon.
    def get_coupon(site_id: nil, coupon_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/coupons/{coupon_id}", site_id: site_id, coupon_id: coupon_id)
      get(path)
    end

    # Update an active coupon
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param coupon_id [String] Coupon ID or code (use prefix: `code-`, e.g. `code-10off`).
    # @param body [Requests::UpdateCoupon] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::UpdateCoupon}.
    # @return [Resources::Coupon] The updated coupon.
    def update_coupon(site_id: nil, coupon_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/coupons/{coupon_id}", site_id: site_id, coupon_id: coupon_id)
      put(path, body, Requests::UpdateCoupon)
    end

    # List unique coupon codes associated with a bulk coupon
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param coupon_id [String] Coupon ID or code (use prefix: `code-`, e.g. `code-10off`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @return [Pager<Resources::UniqueCouponCode>] A list of unique coupon codes that were generated
    def list_unique_coupon_codes(site_id: nil, coupon_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/coupons/{coupon_id}/unique_coupon_codes", site_id: site_id, coupon_id: coupon_id)
      pager(path, **options)
    end

    # List a site's credit payments
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @return [Pager<Resources::CreditPayment>] A list of the site's credit payments.
    def list_credit_payments(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/credit_payments", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a credit payment
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param credit_payment_id [String] Credit Payment ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @return [Resources::CreditPayment] A credit payment.
    def get_credit_payment(site_id: nil, credit_payment_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/credit_payments/{credit_payment_id}", site_id: site_id, credit_payment_id: credit_payment_id)
      get(path)
    end

    # List a site's invoices
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param type [String] Filter by type when: - `type=charge`, only charge invoices will be returned. - `type=credit`, only credit invoices will be returned. - `type=non-legacy`, only charge and credit invoices will be returned. - `type=legacy`, only legacy invoices will be returned.
    # @return [Pager<Resources::Invoice>] A list of the site's invoices.
    def list_invoices(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices", site_id: site_id)
      pager(path, **options)
    end

    # Fetch an invoice
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @return [Resources::Invoice] An invoice.
    def get_invoice(site_id: nil, invoice_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}", site_id: site_id, invoice_id: invoice_id)
      get(path)
    end

    # Collect a pending or past due, automatic invoice
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @return [Resources::Invoice] The updated invoice.
    def collect_invoice(site_id: nil, invoice_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/collect", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Mark an open invoice as failed
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @return [Resources::Invoice] The updated invoice.
    def fail_invoice(site_id: nil, invoice_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/mark_failed", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Mark an open invoice as successful
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @return [Resources::Invoice] The updated invoice.
    def mark_invoice_successful(site_id: nil, invoice_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/mark_successful", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # Reopen a closed, manual invoice
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @return [Resources::Invoice] The updated invoice.
    def reopen_invoice(site_id: nil, invoice_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/reopen", site_id: site_id, invoice_id: invoice_id)
      put(path)
    end

    # List a invoice's line items
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param original [String] Filter by original field.
    # @param state [String] Filter by state field.
    # @param type [String] Filter by type field.
    # @return [Pager<Resources::LineItem>] A list of the invoice's line items.
    def list_invoice_line_items(site_id: nil, invoice_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/line_items", site_id: site_id, invoice_id: invoice_id)
      pager(path, **options)
    end

    # Show the coupon redemptions applied to an invoice
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @return [Pager<Resources::CouponRedemption>] A list of the the coupon redemptions associated with the invoice.
    def list_invoice_coupon_redemptions(site_id: nil, invoice_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/coupon_redemptions", site_id: site_id, invoice_id: invoice_id)
      pager(path, **options)
    end

    # List an invoice's related credit or charge invoices
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @return [Pager<Resources::Invoice>] A list of the credit or charge invoices associated with the invoice.
    def list_related_invoices(site_id: nil, invoice_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/related_invoices", site_id: site_id, invoice_id: invoice_id)
      pager(path)
    end

    # Refund an invoice
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param invoice_id [String] Invoice ID or number (use prefix: `number-`, e.g. `number-1000`).
    # @param body [Requests::InvoiceRefund] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::InvoiceRefund}.
    # @return [Resources::Invoice] Returns the new credit invoice.
    def refund_invoice(site_id: nil, invoice_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/invoices/{invoice_id}/refund", site_id: site_id, invoice_id: invoice_id)
      post(path, body, Requests::InvoiceRefund)
    end

    # List a site's line items
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param original [String] Filter by original field.
    # @param state [String] Filter by state field.
    # @param type [String] Filter by type field.
    # @return [Pager<Resources::LineItem>] A list of the site's line items.
    def list_line_items(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/line_items", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a line item
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param line_item_id [String] Line Item ID.
    # @return [Resources::LineItem] A line item.
    def get_line_item(site_id: nil, line_item_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/line_items/{line_item_id}", site_id: site_id, line_item_id: line_item_id)
      get(path)
    end

    # Delete an uninvoiced line item
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param line_item_id [String] Line Item ID.
    def remove_line_item(site_id: nil, line_item_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/line_items/{line_item_id}", site_id: site_id, line_item_id: line_item_id)
      delete(path)
    end

    # List a site's plans
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param state [String] Filter by state.
    # @return [Pager<Resources::Plan>] A list of plans.
    def list_plans(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans", site_id: site_id)
      pager(path, **options)
    end

    # Create a plan
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param body [Requests::PlanCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanCreate}.
    # @return [Resources::Plan] A plan.
    def create_plan(site_id: nil, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans", site_id: site_id)
      post(path, body, Requests::PlanCreate)
    end

    # Fetch a plan
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param plan_id [String] Plan ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @return [Resources::Plan] A plan.
    def get_plan(site_id: nil, plan_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}", site_id: site_id, plan_id: plan_id)
      get(path)
    end

    # Update a plan
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param plan_id [String] Plan ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @param body [Requests::PlanUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::PlanUpdate}.
    # @return [Resources::Plan] A plan.
    def update_plan(site_id: nil, plan_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}", site_id: site_id, plan_id: plan_id)
      put(path, body, Requests::PlanUpdate)
    end

    # Remove a plan
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param plan_id [String] Plan ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @return [Resources::Plan] Plan deleted
    def remove_plan(site_id: nil, plan_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}", site_id: site_id, plan_id: plan_id)
      delete(path)
    end

    # List a plan's add-ons
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param plan_id [String] Plan ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param state [String] Filter by state.
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    def list_plan_add_ons(site_id: nil, plan_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons", site_id: site_id, plan_id: plan_id)
      pager(path, **options)
    end

    # Create an add-on
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param plan_id [String] Plan ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @param body [Requests::AddOnCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnCreate}.
    # @return [Resources::AddOn] An add-on.
    def create_plan_add_on(site_id: nil, plan_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons", site_id: site_id, plan_id: plan_id)
      post(path, body, Requests::AddOnCreate)
    end

    # Fetch a plan's add-on
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param add_on_id [String] Add-on ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @param plan_id [String] Plan ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @return [Resources::AddOn] An add-on.
    def get_plan_add_on(site_id: nil, add_on_id:, plan_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons/{add_on_id}", site_id: site_id, add_on_id: add_on_id, plan_id: plan_id)
      get(path)
    end

    # Update an add-on
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param add_on_id [String] Add-on ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @param plan_id [String] Plan ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @param body [Requests::AddOnUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::AddOnUpdate}.
    # @return [Resources::AddOn] An add-on.
    def update_plan_add_on(site_id: nil, add_on_id:, plan_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons/{add_on_id}", site_id: site_id, add_on_id: add_on_id, plan_id: plan_id)
      put(path, body, Requests::AddOnUpdate)
    end

    # Remove an add-on
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param add_on_id [String] Add-on ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @param plan_id [String] Plan ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @return [Resources::AddOn] Add-on deleted
    def remove_plan_add_on(site_id: nil, add_on_id:, plan_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/plans/{plan_id}/add_ons/{add_on_id}", site_id: site_id, add_on_id: add_on_id, plan_id: plan_id)
      delete(path)
    end

    # List a site's add-ons
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param state [String] Filter by state.
    # @return [Pager<Resources::AddOn>] A list of add-ons.
    def list_add_ons(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/add_ons", site_id: site_id)
      pager(path, **options)
    end

    # Fetch an add-on
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param add_on_id [String] Add-on ID or code (use prefix: `code-`, e.g. `code-gold`).
    # @return [Resources::AddOn] An add-on.
    def get_add_on(site_id: nil, add_on_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/add_ons/{add_on_id}", site_id: site_id, add_on_id: add_on_id)
      get(path)
    end

    # List a site's subscriptions
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param state [String] Filter by state. - When `state=active`, `state=canceled`, `state=expired`, or `state=future`, subscriptions with states that match the query and only those subscriptions will be returned. - When `state=in_trial`, only subscriptions that have a trial_started_at date earlier than now and a trial_ends_at date later than now will be returned. - When `state=live`, only subscriptions that are in an active, canceled, or future state or are in trial will be returned.
    # @return [Pager<Resources::Subscription>] A list of the site's subscriptions.
    def list_subscriptions(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions", site_id: site_id)
      pager(path, **options)
    end

    # Create a new subscription
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param body [Requests::SubscriptionCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionCreate}.
    # @return [Resources::Subscription] A subscription.
    def create_subscription(site_id: nil, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions", site_id: site_id)
      post(path, body, Requests::SubscriptionCreate)
    end

    # Fetch a subscription
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @return [Resources::Subscription] A subscription.
    # @example
    #   begin
    #     # You can use the `id` field from a Subscription object
    #     subscription = @client.get_subscription(subscription_id: "hympfmu77b4d")
    #     # If you have the uuid, you can prefix with `uuid-`
    #     subscription = @client.get_subscription(subscription_id: "uuid-419cd2effd49236e502ccc42db928280")
    #   rescue Recurly::Errors::NotFoundError => e
    #     puts e
    #     # => Recurly::NotFoundError: Couldn't Subscription with uuid = 419cd2effd49236e502ccc42db928280
    #     puts e.recurly_error
    #     # => #<Recurly::Error:0x007f8b29918618 @attributes={:type=>"not_found", :message=>"Couldn't find Subscription with uuid = 419cd2effd49236e502ccc42db928280", :params=>[{"param"=>"subscription_id"}]}>
    #   end
    #
    def get_subscription(site_id: nil, subscription_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      get(path)
    end

    # Modify a subscription
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @param body [Requests::SubscriptionUpdate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionUpdate}.
    # @return [Resources::Subscription] A subscription.
    def modify_subscription(site_id: nil, subscription_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      put(path, body, Requests::SubscriptionUpdate)
    end

    # Terminate a subscription
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @param refund [String] The type of refund to perform:  * `full` - Performs a full refund of the last invoice for the current subscription term. * `partial` - Prorates a refund based on the amount of time remaining in the current bill cycle. * `none` - Terminates the subscription without a refund.  In the event that the most recent invoice is a $0 invoice paid entirely by credit, Recurly will apply the credit back to the customer’s account.  You may also terminate a subscription with no refund and then manually refund specific invoices.
    # @return [Resources::Subscription] An expired subscription.
    def terminate_subscription(site_id: nil, subscription_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}", site_id: site_id, subscription_id: subscription_id)
      delete(path, **options)
    end

    # Cancel a subscription
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @return [Resources::Subscription] A canceled or failed subscription.
    def cancel_subscription(site_id: nil, subscription_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/cancel", site_id: site_id, subscription_id: subscription_id)
      put(path)
    end

    # Reactivate a canceled subscription
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @return [Resources::Subscription] An active subscription.
    def reactivate_subscription(site_id: nil, subscription_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/reactivate", site_id: site_id, subscription_id: subscription_id)
      put(path)
    end

    # Fetch a subscription's pending change
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @return [Resources::SubscriptionChange] A subscription's pending change.
    def get_subscription_change(site_id: nil, subscription_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      get(path)
    end

    # Create a new subscription change
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @param body [Requests::SubscriptionChangeCreate] The Hash representing the JSON request to send to the server. It should conform to the schema of {Requests::SubscriptionChangeCreate}.
    # @return [Resources::SubscriptionChange] A subscription change.
    def create_subscription_change(site_id: nil, subscription_id:, body:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      post(path, body, Requests::SubscriptionChangeCreate)
    end

    # Delete the pending subscription change
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    def remove_subscription_change(site_id: nil, subscription_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/change", site_id: site_id, subscription_id: subscription_id)
      delete(path)
    end

    # List a subscription's invoices
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param subscription_id [String] Subscription ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param type [String] Filter by type when: - `type=charge`, only charge invoices will be returned. - `type=credit`, only credit invoices will be returned. - `type=non-legacy`, only charge and credit invoices will be returned. - `type=legacy`, only legacy invoices will be returned.
    # @return [Pager<Resources::Invoice>] A list of the subscription's invoices.
    def list_subscription_invoices(site_id: nil, subscription_id:, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/subscriptions/{subscription_id}/invoices", site_id: site_id, subscription_id: subscription_id)
      pager(path, **options)
    end

    # List a site's transactions
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param ids [String] Filter results by their IDs. Up to 200 IDs can be passed at once using commas as separators, e.g. `ids=h1at4d57xlmy,gyqgg0d3v9n1`.  **Important notes:** * The `ids` parameter cannot be used with any other ordering or filtering   parameters (`limit`, `order`, `sort`, `begin_time`, `end_time`, etc) * Invalid or unknown IDs will be ignored, so you should check that the   results correspond to your request. * Records are returned in an arbitrary order. Since results are all   returned at once you can sort the records yourself.
    # @param limit [Integer] Limit number of records 1-200.
    # @param order [String] Sort order.
    # @param sort [String] Sort field. You *really* only want to sort by `updated_at` in ascending order. In descending order updated records will move behind the cursor and could prevent some records from being returned.
    # @param begin_time [DateTime] Filter by begin_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param end_time [DateTime] Filter by end_time when `sort=created_at` or `sort=updated_at`. **Note:** this value is an ISO8601 timestamp. A partial timestamp that does not include a time zone will default to UTC.
    # @param type [String] Filter by type field.
    # @param success [String] Filter by success field.
    # @return [Pager<Resources::Transaction>] A list of the site's transactions.
    def list_transactions(site_id: nil, **options)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/transactions", site_id: site_id)
      pager(path, **options)
    end

    # Fetch a transaction
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param transaction_id [String] Transaction ID or UUID (use prefix: `uuid-`, e.g. `uuid-123457890`).
    # @return [Resources::Transaction] A transaction.
    def get_transaction(site_id: nil, transaction_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/transactions/{transaction_id}", site_id: site_id, transaction_id: transaction_id)
      get(path)
    end

    # Fetch a unique coupon code
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: `code-`, e.g. `code-abc-8dh2-def`).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def get_unique_coupon_code(site_id: nil, unique_coupon_code_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      get(path)
    end

    # Deactivate a unique coupon code
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: `code-`, e.g. `code-abc-8dh2-def`).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def deactivate_unique_coupon_code(site_id: nil, unique_coupon_code_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      delete(path)
    end

    # Restore a unique coupon code
    #
    # @param site_id [String] Site ID or subdomain (use prefix: `subdomain-`, e.g. `subdomain-recurly`). This parameter is required unless you set the site_id when initializing the client.
    # @param unique_coupon_code_id [String] Unique Coupon Code ID or code (use prefix: `code-`, e.g. `code-abc-8dh2-def`).
    # @return [Resources::UniqueCouponCode] A unique coupon code.
    def reactivate_unique_coupon_code(site_id: nil, unique_coupon_code_id:)
      site_id = validate_site_id!(site_id)
      path = interpolate_path("/sites/{site_id}/unique_coupon_codes/{unique_coupon_code_id}/restore", site_id: site_id, unique_coupon_code_id: unique_coupon_code_id)
      put(path)
    end
  end
end