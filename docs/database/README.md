# Dansdata

## Tables

| Name | Columns | Comment | Type |
| ---- | ------- | ------- | ---- |
| [auth.users](auth.users.md) | 34 | Auth: Stores user login data within a secure schema. | BASE TABLE |
| [profiles.base_images](profiles.base_images.md) | 2 |  | BASE TABLE |
| [profiles.base_translations](profiles.base_translations.md) | 4 |  | BASE TABLE |
| [profiles.categories](profiles.categories.md) | 5 |  | BASE TABLE |
| [profiles.category_descriptions](profiles.category_descriptions.md) | 5 |  | BASE TABLE |
| [profiles.category_names](profiles.category_names.md) | 5 |  | BASE TABLE |
| [profiles.image_formats](profiles.image_formats.md) | 8 |  | BASE TABLE |
| [profiles.individuals](profiles.individuals.md) | 5 |  | BASE TABLE |
| [profiles.languages](profiles.languages.md) | 1 |  | VIEW |
| [profiles.membership_titles](profiles.membership_titles.md) | 5 |  | BASE TABLE |
| [profiles.organization_members](profiles.organization_members.md) | 3 |  | BASE TABLE |
| [profiles.organizations](profiles.organizations.md) | 4 |  | BASE TABLE |
| [profiles.profile_categories](profiles.profile_categories.md) | 3 | Describes which categories this profile is related to.<br><br>Useful when performing searches to filter out unwanted categories. | BASE TABLE |
| [profiles.profile_descriptions](profiles.profile_descriptions.md) | 5 |  | BASE TABLE |
| [profiles.profile_images](profiles.profile_images.md) | 3 |  | BASE TABLE |
| [profiles.profile_images_dangling](profiles.profile_images_dangling.md) | 9 |  | VIEW |
| [profiles.profile_links](profiles.profile_links.md) | 3 |  | BASE TABLE |
| [profiles.profiles](profiles.profiles.md) | 2 |  | BASE TABLE |
| [profiles.profiles_dangling](profiles.profiles_dangling.md) | 2 |  | VIEW |
| [profiles.venues](profiles.venues.md) | 4 |  | BASE TABLE |

## Stored procedures and functions

| Name | ReturnType | Arguments | Type |
| ---- | ------- | ------- | ---- |
| net.check_worker_is_up | void |  | FUNCTION |
| net._await_response | bool | request_id bigint | FUNCTION |
| net._urlencode_string | text | string character varying | FUNCTION |
| net._encode_url_with_params_array | text | url text, params_array text[] | FUNCTION |
| pgsodium.crypto_sign | bytea | message bytea, key bytea | FUNCTION |
| pgsodium.crypto_sign_open | bytea | signed_message bytea, key bytea | FUNCTION |
| pgsodium.crypto_sign_detached | bytea | message bytea, key bytea | FUNCTION |
| pgsodium.crypto_sign_verify_detached | bool | sig bytea, message bytea, key bytea | FUNCTION |
| pgsodium.crypto_pwhash_saltgen | bytea |  | FUNCTION |
| pgsodium.crypto_pwhash | bytea | password bytea, salt bytea | FUNCTION |
| pgsodium.crypto_pwhash_str | bytea | password bytea | FUNCTION |
| pgsodium.crypto_pwhash_str_verify | bool | hashed_password bytea, password bytea | FUNCTION |
| pgsodium.crypto_box_seal | bytea | message bytea, public_key bytea | FUNCTION |
| pgsodium.crypto_box_seal_open | bytea | ciphertext bytea, public_key bytea, secret_key bytea | FUNCTION |
| pgsodium.crypto_box_new_seed | bytea |  | FUNCTION |
| pgsodium.crypto_kx_client_session_keys | crypto_kx_session | client_pk bytea, client_sk bytea, server_pk bytea | FUNCTION |
| pgsodium.crypto_kx_server_session_keys | crypto_kx_session | server_pk bytea, server_sk bytea, client_pk bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha512_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_sign_update_agg | bytea | message bytea | a |
| pgsodium.crypto_sign_update_agg | bytea | state bytea, message bytea | a |
| pgsodium.crypto_sign_new_seed | bytea |  | FUNCTION |
| pgsodium.crypto_sign_seed_new_keypair | crypto_sign_keypair | seed bytea | FUNCTION |
| pgsodium.crypto_hash_sha256 | bytea | message bytea | FUNCTION |
| pgsodium.crypto_hash_sha512 | bytea | message bytea | FUNCTION |
| pgsodium.derive_key | bytea | key_id bigint, key_len integer DEFAULT 32, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.pgsodium_derive | bytea | key_id bigint, key_len integer DEFAULT 32, context bytea DEFAULT decode('pgsodium'::text, 'escape'::text) | FUNCTION |
| pgsodium.randombytes_new_seed | bytea |  | FUNCTION |
| pgsodium.crypto_secretbox_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_auth_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_box_noncegen | bytea |  | FUNCTION |
| pgsodium.crypto_aead_ietf_keygen | bytea |  | FUNCTION |
| extensions.postgis_cache_bbox | trigger |  | FUNCTION |
| pgsodium.crypto_kdf_derive_from_key | bytea | subkey_size bigint, subkey_id bigint, context bytea, primary_key bytea | FUNCTION |
| extensions.st_makepoint | geometry | double precision, double precision | FUNCTION |
| extensions.st_makepoint | geometry | double precision, double precision, double precision | FUNCTION |
| extensions.st_makepoint | geometry | double precision, double precision, double precision, double precision | FUNCTION |
| extensions.st_makepointm | geometry | double precision, double precision, double precision | FUNCTION |
| extensions.st_3dmakebox | box3d | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_makeline | geometry | geometry[] | FUNCTION |
| extensions.st_linefrommultipoint | geometry | geometry | FUNCTION |
| extensions.st_makeline | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_addpoint | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_addpoint | geometry | geom1 geometry, geom2 geometry, integer | FUNCTION |
| extensions.st_removepoint | geometry | geometry, integer | FUNCTION |
| extensions.st_setpoint | geometry | geometry, integer, geometry | FUNCTION |
| extensions.st_makeenvelope | geometry | double precision, double precision, double precision, double precision, integer DEFAULT 0 | FUNCTION |
| extensions.st_tileenvelope | geometry | zoom integer, x integer, y integer, bounds geometry DEFAULT '0102000020110F00000200000093107C45F81B73C193107C45F81B73C193107C45F81B734193107C45F81B7341'::geometry, margin double precision DEFAULT 0.0 | FUNCTION |
| extensions.st_makepolygon | geometry | geometry, geometry[] | FUNCTION |
| extensions.st_makepolygon | geometry | geometry | FUNCTION |
| pgsodium.crypto_shorthash_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_generichash_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_kdf_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_kx_new_keypair | crypto_kx_keypair |  | FUNCTION |
| pgsodium.crypto_kx_new_seed | bytea |  | FUNCTION |
| pgsodium.crypto_kx_seed_new_keypair | crypto_kx_keypair | seed bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha256_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_box_seed_new_keypair | crypto_box_keypair | seed bytea | FUNCTION |
| pgsodium.crypto_box_new_keypair | crypto_box_keypair |  | FUNCTION |
| pgsodium.crypto_sign_new_keypair | crypto_sign_keypair |  | FUNCTION |
| pgsodium.crypto_secretbox | bytea | message bytea, nonce bytea, key bytea | FUNCTION |
| pgsodium.crypto_secretbox_open | bytea | ciphertext bytea, nonce bytea, key bytea | FUNCTION |
| pgsodium.crypto_auth | bytea | message bytea, key bytea | FUNCTION |
| pgsodium.crypto_auth_verify | bool | mac bytea, message bytea, key bytea | FUNCTION |
| pgsodium.crypto_box | bytea | message bytea, nonce bytea, public bytea, secret bytea | FUNCTION |
| pgsodium.crypto_box_open | bytea | ciphertext bytea, nonce bytea, public bytea, secret bytea | FUNCTION |
| pgsodium.crypto_aead_ietf_encrypt | bytea | message bytea, additional bytea, nonce bytea, key bytea | FUNCTION |
| pgsodium.crypto_aead_ietf_decrypt | bytea | message bytea, additional bytea, nonce bytea, key bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha256 | bytea | message bytea, secret bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha256_verify | bool | hash bytea, message bytea, secret bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha512 | bytea | message bytea, secret bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha512_verify | bool | hash bytea, message bytea, secret bytea | FUNCTION |
| pgsodium.crypto_sign_init | bytea |  | FUNCTION |
| pgsodium.crypto_sign_update | bytea | state bytea, message bytea | FUNCTION |
| pgsodium.crypto_sign_final_create | bytea | state bytea, key bytea | FUNCTION |
| pgsodium.crypto_sign_final_verify | bool | state bytea, signature bytea, key bytea | FUNCTION |
| pgsodium.crypto_sign_update_agg1 | bytea | state bytea, message bytea | FUNCTION |
| pgsodium.crypto_sign_update_agg2 | bytea | cur_state bytea, initial_state bytea, message bytea | FUNCTION |
| pgsodium.randombytes_random | int4 |  | FUNCTION |
| pgsodium.randombytes_uniform | int4 | upper_bound integer | FUNCTION |
| pgsodium.randombytes_buf | bytea | size integer | FUNCTION |
| pgsodium.randombytes_buf_deterministic | bytea | size integer, seed bytea | FUNCTION |
| pgsodium.crypto_secretbox_noncegen | bytea |  | FUNCTION |
| pgsodium.crypto_aead_ietf_noncegen | bytea |  | FUNCTION |
| pgsodium.crypto_secretbox | bytea | message bytea, nonce bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_secretbox_open | bytea | message bytea, nonce bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_aead_ietf_encrypt | bytea | message bytea, additional bytea, nonce bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_aead_ietf_decrypt | bytea | message bytea, additional bytea, nonce bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_auth | bytea | message bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_auth_verify | bool | mac bytea, message bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_generichash | bytea | message bytea, key bytea DEFAULT NULL::bytea | FUNCTION |
| pgsodium.crypto_shorthash | bytea | message bytea, key bytea | FUNCTION |
| pgsodium.crypto_secretstream_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_stream_xchacha20_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_stream_xchacha20_noncegen | bytea |  | FUNCTION |
| pgsodium.crypto_stream_xchacha20 | bytea | bigint, bytea, bytea | FUNCTION |
| pgsodium.crypto_stream_xchacha20_xor | bytea | bytea, bytea, bytea | FUNCTION |
| pgsodium.crypto_stream_xchacha20_xor_ic | bytea | bytea, bytea, bigint, bytea | FUNCTION |
| pgsodium.crypto_stream_xchacha20 | bytea | bigint, bytea, bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_stream_xchacha20_xor | bytea | bytea, bytea, bigint, context bytea DEFAULT '\x70676f736469756d'::bytea | FUNCTION |
| pgsodium.crypto_stream_xchacha20_xor_ic | bytea | bytea, bytea, bigint, bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_cmp | bool | text, text | FUNCTION |
| pgsodium.crypto_signcrypt_new_keypair | crypto_signcrypt_keypair |  | FUNCTION |
| pgsodium.crypto_generichash | bytea | message bytea, key bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_shorthash | bytea | message bytea, key bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha512 | bytea | message bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha512_verify | bool | hash bytea, message bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha256 | bytea | message bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.crypto_auth_hmacsha256_verify | bool | hash bytea, message bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea | FUNCTION |
| pgsodium.sodium_bin2base64 | text | bin bytea | FUNCTION |
| pgsodium.sodium_base642bin | bytea | base64 text | FUNCTION |
| pgsodium.crypto_aead_det_keygen | bytea |  | FUNCTION |
| pgsodium.crypto_signcrypt_sign_before | crypto_signcrypt_state_key | sender bytea, recipient bytea, sender_sk bytea, recipient_pk bytea, additional bytea | FUNCTION |
| pgsodium.crypto_signcrypt_sign_after | bytea | state bytea, sender_sk bytea, ciphertext bytea | FUNCTION |
| pgsodium.crypto_signcrypt_verify_before | crypto_signcrypt_state_key | signature bytea, sender bytea, recipient bytea, additional bytea, sender_pk bytea, recipient_sk bytea | FUNCTION |
| pgsodium.crypto_signcrypt_verify_after | bool | state bytea, signature bytea, sender_pk bytea, ciphertext bytea | FUNCTION |
| pgsodium.crypto_signcrypt_verify_public | bool | signature bytea, sender bytea, recipient bytea, additional bytea, sender_pk bytea, ciphertext bytea | FUNCTION |
| pgsodium.crypto_aead_det_encrypt | bytea | message bytea, additional bytea, key bytea, nonce bytea DEFAULT NULL::bytea | FUNCTION |
| pgsodium.crypto_aead_det_decrypt | bytea | ciphertext bytea, additional bytea, key bytea, nonce bytea DEFAULT NULL::bytea | FUNCTION |
| pgsodium.crypto_aead_det_encrypt | bytea | message bytea, additional bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea, nonce bytea DEFAULT NULL::bytea | FUNCTION |
| pgsodium.crypto_aead_det_decrypt | bytea | message bytea, additional bytea, key_id bigint, context bytea DEFAULT '\x7067736f6469756d'::bytea, nonce bytea DEFAULT NULL::bytea | FUNCTION |
| pgsodium.version | text |  | FUNCTION |
| pgsodium.create_key | key | comment text DEFAULT NULL::text, key_type pgsodium.key_type DEFAULT 'aead-det'::pgsodium.key_type, key_id bigint DEFAULT NULL::bigint, key_context bytea DEFAULT '\x7067736f6469756d'::bytea, expires timestamp without time zone DEFAULT NULL::timestamp without time zone, user_data jsonb DEFAULT NULL::jsonb | FUNCTION |
| pgsodium.crypto_aead_det_noncegen | bytea |  | FUNCTION |
| pgsodium.crypto_aead_det_encrypt | bytea | message bytea, additional bytea, key_uuid uuid | FUNCTION |
| pgsodium.crypto_aead_det_decrypt | bytea | message bytea, additional bytea, key_uuid uuid | FUNCTION |
| pgsodium.crypto_aead_ietf_encrypt | bytea | message bytea, additional bytea, nonce bytea, key_uuid uuid | FUNCTION |
| pgsodium.crypto_aead_ietf_decrypt | bytea | message bytea, additional bytea, nonce bytea, key_uuid uuid | FUNCTION |
| pgsodium.has_mask | bool | role regrole, source_name text | FUNCTION |
| pgsodium.mask_columns | record | source_relid oid | FUNCTION |
| pgsodium.create_mask_view | void | relid oid, debug boolean DEFAULT false | FUNCTION |
| pgsodium.trg_mask_update | event_trigger |  | FUNCTION |
| pgsodium.mask_role | void | masked_role regrole, source_name text, view_name text | FUNCTION |
| pgsodium.update_masks | void | debug boolean DEFAULT false | FUNCTION |
| pgsodium.crypto_aead_det_encrypt | bytea | message bytea, additional bytea, key_uuid uuid, nonce bytea | FUNCTION |
| pgsodium.crypto_aead_det_decrypt | bytea | message bytea, additional bytea, key_uuid uuid, nonce bytea | FUNCTION |
| pgsodium.encrypted_columns | text | relid oid | FUNCTION |
| pgsodium.decrypted_columns | text | relid oid | FUNCTION |
| extensions.grant_pg_graphql_access | event_trigger |  | FUNCTION |
| extensions.pgrst_ddl_watch | event_trigger |  | FUNCTION |
| extensions.pgrst_drop_watch | event_trigger |  | FUNCTION |
| extensions.set_graphql_placeholder | event_trigger |  | FUNCTION |
| extensions.st_buildarea | geometry | geometry | FUNCTION |
| extensions.st_polygonize | geometry | geometry[] | FUNCTION |
| extensions.st_clusterintersecting | _geometry | geometry[] | FUNCTION |
| extensions.st_clusterwithin | _geometry | geometry[], double precision | FUNCTION |
| extensions.st_clusterdbscan | int4 | geometry, eps double precision, minpoints integer | w |
| extensions.st_linemerge | geometry | geometry | FUNCTION |
| extensions.st_affine | geometry | geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision | FUNCTION |
| extensions.st_affine | geometry | geometry, double precision, double precision, double precision, double precision, double precision, double precision | FUNCTION |
| extensions.st_rotate | geometry | geometry, double precision | FUNCTION |
| extensions.st_rotate | geometry | geometry, double precision, double precision, double precision | FUNCTION |
| extensions.st_rotate | geometry | geometry, double precision, geometry | FUNCTION |
| extensions.st_rotatez | geometry | geometry, double precision | FUNCTION |
| extensions.st_rotatex | geometry | geometry, double precision | FUNCTION |
| extensions.st_rotatey | geometry | geometry, double precision | FUNCTION |
| extensions.st_translate | geometry | geometry, double precision, double precision, double precision | FUNCTION |
| extensions.st_translate | geometry | geometry, double precision, double precision | FUNCTION |
| extensions.st_scale | geometry | geometry, geometry | FUNCTION |
| extensions.st_scale | geometry | geometry, geometry, origin geometry | FUNCTION |
| storage.get_size_by_bucket | record |  | FUNCTION |
| storage.search | record | prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text | FUNCTION |
| storage.update_updated_at_column | trigger |  | FUNCTION |
| extensions.gen_salt | text | text, integer | FUNCTION |
| extensions.grant_pg_cron_access | event_trigger |  | FUNCTION |
| extensions.pgp_pub_encrypt_bytea | bytea | bytea, bytea, text | FUNCTION |
| auth.email | text |  | FUNCTION |
| auth.jwt | jsonb |  | FUNCTION |
| auth.role | text |  | FUNCTION |
| auth.uid | uuid |  | FUNCTION |
| extensions.algorithm_sign | text | signables text, secret text, algorithm text | FUNCTION |
| extensions.armor | text | bytea | FUNCTION |
| extensions.armor | text | bytea, text[], text[] | FUNCTION |
| extensions.crypt | text | text, text | FUNCTION |
| extensions.dearmor | bytea | text | FUNCTION |
| extensions.decrypt | bytea | bytea, bytea, text | FUNCTION |
| extensions.decrypt_iv | bytea | bytea, bytea, bytea, text | FUNCTION |
| extensions.digest | bytea | bytea, text | FUNCTION |
| extensions.digest | bytea | text, text | FUNCTION |
| extensions.encrypt | bytea | bytea, bytea, text | FUNCTION |
| extensions.encrypt_iv | bytea | bytea, bytea, bytea, text | FUNCTION |
| extensions.gen_random_bytes | bytea | integer | FUNCTION |
| extensions.gen_random_uuid | uuid |  | FUNCTION |
| extensions.gen_salt | text | text | FUNCTION |
| extensions.grant_pg_net_access | event_trigger |  | FUNCTION |
| extensions.hmac | bytea | bytea, bytea, text | FUNCTION |
| extensions.hmac | bytea | text, text, text | FUNCTION |
| extensions.pg_stat_statements | record | showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric | FUNCTION |
| extensions.pg_stat_statements_info | record | OUT dealloc bigint, OUT stats_reset timestamp with time zone | FUNCTION |
| extensions.pg_stat_statements_reset | void | userid oid DEFAULT 0, dbid oid DEFAULT 0, queryid bigint DEFAULT 0 | FUNCTION |
| extensions.pgp_armor_headers | record | text, OUT key text, OUT value text | FUNCTION |
| extensions.pgp_key_id | text | bytea | FUNCTION |
| extensions.pgp_pub_decrypt | text | bytea, bytea | FUNCTION |
| extensions.pgp_pub_decrypt | text | bytea, bytea, text | FUNCTION |
| extensions.pgp_pub_decrypt | text | bytea, bytea, text, text | FUNCTION |
| extensions.pgp_pub_decrypt_bytea | bytea | bytea, bytea | FUNCTION |
| extensions.pgp_pub_decrypt_bytea | bytea | bytea, bytea, text | FUNCTION |
| extensions.pgp_pub_decrypt_bytea | bytea | bytea, bytea, text, text | FUNCTION |
| extensions.pgp_pub_encrypt | bytea | text, bytea | FUNCTION |
| extensions.pgp_pub_encrypt | bytea | text, bytea, text | FUNCTION |
| extensions.pgp_pub_encrypt_bytea | bytea | bytea, bytea | FUNCTION |
| extensions.pgp_sym_decrypt | text | bytea, text | FUNCTION |
| extensions.pgp_sym_decrypt | text | bytea, text, text | FUNCTION |
| extensions.pgp_sym_decrypt_bytea | bytea | bytea, text | FUNCTION |
| extensions.pgp_sym_decrypt_bytea | bytea | bytea, text, text | FUNCTION |
| extensions.pgp_sym_encrypt | bytea | text, text | FUNCTION |
| extensions.pgp_sym_encrypt | bytea | text, text, text | FUNCTION |
| extensions.pgp_sym_encrypt_bytea | bytea | bytea, text | FUNCTION |
| extensions.pgp_sym_encrypt_bytea | bytea | bytea, text, text | FUNCTION |
| extensions.sign | text | payload json, secret text, algorithm text DEFAULT 'HS256'::text | FUNCTION |
| extensions.try_cast_double | float8 | inp text | FUNCTION |
| extensions.url_decode | bytea | data text | FUNCTION |
| extensions.url_encode | text | data bytea | FUNCTION |
| extensions.uuid_generate_v1 | uuid |  | FUNCTION |
| extensions.uuid_generate_v1mc | uuid |  | FUNCTION |
| extensions.uuid_generate_v3 | uuid | namespace uuid, name text | FUNCTION |
| extensions.uuid_generate_v4 | uuid |  | FUNCTION |
| extensions.uuid_generate_v5 | uuid | namespace uuid, name text | FUNCTION |
| extensions.uuid_nil | uuid |  | FUNCTION |
| extensions.uuid_ns_dns | uuid |  | FUNCTION |
| extensions.uuid_ns_oid | uuid |  | FUNCTION |
| extensions.uuid_ns_url | uuid |  | FUNCTION |
| extensions.uuid_ns_x500 | uuid |  | FUNCTION |
| extensions.verify | record | token text, secret text, algorithm text DEFAULT 'HS256'::text | FUNCTION |
| extensions.geometry_within | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_left | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_overleft | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_below | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_overbelow | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_overright | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_right | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_overabove | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_above | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_gist_consistent_nd | bool | internal, geometry, integer | FUNCTION |
| extensions.geometry_gist_compress_nd | internal | internal | FUNCTION |
| extensions.geometry_gist_penalty_nd | internal | internal, internal, internal | FUNCTION |
| extensions.geometry_gist_picksplit_nd | internal | internal, internal | FUNCTION |
| extensions.geometry_gist_union_nd | internal | bytea, internal | FUNCTION |
| extensions.geometry_gist_same_nd | internal | geometry, geometry, internal | FUNCTION |
| extensions.geometry_gist_decompress_nd | internal | internal | FUNCTION |
| extensions.geometry_overlaps_nd | bool | geometry, geometry | FUNCTION |
| extensions.geometry_contains_nd | bool | geometry, geometry | FUNCTION |
| extensions.geometry_within_nd | bool | geometry, geometry | FUNCTION |
| extensions.geometry_same_nd | bool | geometry, geometry | FUNCTION |
| extensions.geometry_distance_centroid_nd | float8 | geometry, geometry | FUNCTION |
| extensions.geometry_distance_cpa | float8 | geometry, geometry | FUNCTION |
| extensions.geometry_gist_distance_nd | float8 | internal, geometry, integer | FUNCTION |
| extensions.st_shiftlongitude | geometry | geometry | FUNCTION |
| extensions.st_wrapx | geometry | geom geometry, wrap double precision, move double precision | FUNCTION |
| extensions.st_xmin | float8 | box3d | FUNCTION |
| extensions.st_ymin | float8 | box3d | FUNCTION |
| extensions.st_zmin | float8 | box3d | FUNCTION |
| extensions.st_xmax | float8 | box3d | FUNCTION |
| extensions.st_ymax | float8 | box3d | FUNCTION |
| extensions.st_zmax | float8 | box3d | FUNCTION |
| extensions.st_expand | box2d | box2d, double precision | FUNCTION |
| storage.filename | text | name text | FUNCTION |
| extensions.st_expand | box2d | box box2d, dx double precision, dy double precision | FUNCTION |
| extensions.postgis_getbbox | box2d | geometry | FUNCTION |
| extensions.st_makebox2d | box2d | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_estimatedextent | box2d | text, text, text, boolean | FUNCTION |
| extensions.st_estimatedextent | box2d | text, text, text | FUNCTION |
| extensions.st_estimatedextent | box2d | text, text | FUNCTION |
| extensions.st_findextent | box2d | text, text, text | FUNCTION |
| extensions.st_findextent | box2d | text, text | FUNCTION |
| extensions.postgis_addbbox | geometry | geometry | FUNCTION |
| extensions.postgis_dropbbox | geometry | geometry | FUNCTION |
| extensions.postgis_hasbbox | bool | geometry | FUNCTION |
| extensions.st_quantizecoordinates | geometry | g geometry, prec_x integer, prec_y integer DEFAULT NULL::integer, prec_z integer DEFAULT NULL::integer, prec_m integer DEFAULT NULL::integer | FUNCTION |
| extensions.st_memsize | int4 | geometry | FUNCTION |
| extensions.st_summary | text | geometry | FUNCTION |
| extensions.st_npoints | int4 | geometry | FUNCTION |
| extensions.st_nrings | int4 | geometry | FUNCTION |
| extensions.st_3dlength | float8 | geometry | FUNCTION |
| extensions.st_length2d | float8 | geometry | FUNCTION |
| extensions.st_length | float8 | geometry | FUNCTION |
| extensions.st_lengthspheroid | float8 | geometry, spheroid | FUNCTION |
| extensions.st_length2dspheroid | float8 | geometry, spheroid | FUNCTION |
| extensions.st_3dperimeter | float8 | geometry | FUNCTION |
| extensions.st_perimeter2d | float8 | geometry | FUNCTION |
| extensions.st_perimeter | float8 | geometry | FUNCTION |
| extensions.st_area2d | float8 | geometry | FUNCTION |
| extensions.st_area | float8 | geometry | FUNCTION |
| extensions.st_ispolygoncw | bool | geometry | FUNCTION |
| net.http_collect_response | http_response_result | request_id bigint, async boolean DEFAULT true | FUNCTION |
| net.http_get | int8 | url text, params jsonb DEFAULT '{}'::jsonb, headers jsonb DEFAULT '{}'::jsonb, timeout_milliseconds integer DEFAULT 2000 | FUNCTION |
| extensions.st_ispolygonccw | bool | geometry | FUNCTION |
| extensions.st_distancespheroid | float8 | geom1 geometry, geom2 geometry, spheroid | FUNCTION |
| extensions.st_distance | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_pointinsidecircle | bool | geometry, double precision, double precision, double precision | FUNCTION |
| extensions.st_azimuth | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_angle | float8 | pt1 geometry, pt2 geometry, pt3 geometry, pt4 geometry DEFAULT '0101000000000000000000F87F000000000000F87F'::geometry | FUNCTION |
| extensions.st_force2d | geometry | geometry | FUNCTION |
| extensions.st_force3dz | geometry | geom geometry, zvalue double precision DEFAULT 0.0 | FUNCTION |
| extensions.st_force3d | geometry | geom geometry, zvalue double precision DEFAULT 0.0 | FUNCTION |
| extensions.st_force3dm | geometry | geom geometry, mvalue double precision DEFAULT 0.0 | FUNCTION |
| extensions.st_force4d | geometry | geom geometry, zvalue double precision DEFAULT 0.0, mvalue double precision DEFAULT 0.0 | FUNCTION |
| extensions.st_forcecollection | geometry | geometry | FUNCTION |
| extensions.st_collectionextract | geometry | geometry, integer | FUNCTION |
| extensions.st_collectionextract | geometry | geometry | FUNCTION |
| extensions.st_collectionhomogenize | geometry | geometry | FUNCTION |
| extensions.st_multi | geometry | geometry | FUNCTION |
| extensions.st_forcecurve | geometry | geometry | FUNCTION |
| extensions.st_forcesfs | geometry | geometry | FUNCTION |
| extensions.st_forcesfs | geometry | geometry, version text | FUNCTION |
| extensions.st_expand | box3d | box3d, double precision | FUNCTION |
| extensions.st_expand | box3d | box box3d, dx double precision, dy double precision, dz double precision DEFAULT 0 | FUNCTION |
| extensions.st_expand | geometry | geometry, double precision | FUNCTION |
| extensions.st_scale | geometry | geometry, double precision, double precision, double precision | FUNCTION |
| extensions.st_scale | geometry | geometry, double precision, double precision | FUNCTION |
| extensions.st_transscale | geometry | geometry, double precision, double precision, double precision, double precision | FUNCTION |
| net.http_post | int8 | url text, body jsonb DEFAULT '{}'::jsonb, params jsonb DEFAULT '{}'::jsonb, headers jsonb DEFAULT '{"Content-Type": "application/json"}'::jsonb, timeout_milliseconds integer DEFAULT 2000 | FUNCTION |
| pgbouncer.get_auth | record | p_usename text | FUNCTION |
| extensions.geometry_typmod_out | cstring | integer | FUNCTION |
| extensions.geometry_analyze | bool | internal | FUNCTION |
| extensions.geometry_recv | geometry | internal | FUNCTION |
| storage.extension | text | name text | FUNCTION |
| extensions.geometry_send | bytea | geometry | FUNCTION |
| extensions.geometry | geometry | geometry, integer, boolean | FUNCTION |
| extensions.geometry | geometry | point | FUNCTION |
| extensions.point | point | geometry | FUNCTION |
| extensions.geometry | geometry | path | FUNCTION |
| extensions.path | path | geometry | FUNCTION |
| extensions.geometry | geometry | polygon | FUNCTION |
| extensions.polygon | polygon | geometry | FUNCTION |
| extensions.st_x | float8 | geometry | FUNCTION |
| extensions.st_y | float8 | geometry | FUNCTION |
| extensions.st_z | float8 | geometry | FUNCTION |
| extensions.st_m | float8 | geometry | FUNCTION |
| extensions.box3d_in | box3d | cstring | FUNCTION |
| extensions.box3d_out | cstring | box3d | FUNCTION |
| extensions.box2d_in | box2d | cstring | FUNCTION |
| extensions.box2d_out | cstring | box2d | FUNCTION |
| extensions.box2df_in | box2df | cstring | FUNCTION |
| extensions.box2df_out | cstring | box2df | FUNCTION |
| extensions.gidx_in | gidx | cstring | FUNCTION |
| extensions.gidx_out | cstring | gidx | FUNCTION |
| extensions.geometry_lt | bool | geom1 geometry, geom2 geometry | FUNCTION |
| storage.foldername | _text | name text | FUNCTION |
| extensions.geometry_le | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_gt | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_ge | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_eq | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_cmp | int4 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_sortsupport | void | internal | FUNCTION |
| extensions.geometry_hash | int4 | geometry | FUNCTION |
| extensions.geometry_gist_distance_2d | float8 | internal, geometry, integer | FUNCTION |
| extensions.geometry_gist_consistent_2d | bool | internal, geometry, integer | FUNCTION |
| extensions.geometry_gist_compress_2d | internal | internal | FUNCTION |
| extensions.geometry_gist_penalty_2d | internal | internal, internal, internal | FUNCTION |
| extensions.geometry_gist_picksplit_2d | internal | internal, internal | FUNCTION |
| extensions.geometry_gist_union_2d | internal | bytea, internal | FUNCTION |
| extensions.geometry_gist_same_2d | internal | geom1 geometry, geom2 geometry, internal | FUNCTION |
| extensions.geometry_gist_decompress_2d | internal | internal | FUNCTION |
| extensions._postgis_selectivity | float8 | tbl regclass, att_name text, geom geometry, mode text DEFAULT '2'::text | FUNCTION |
| extensions._postgis_join_selectivity | float8 | regclass, text, regclass, text, text DEFAULT '2'::text | FUNCTION |
| extensions._postgis_stats | text | tbl regclass, att_name text, text DEFAULT '2'::text | FUNCTION |
| extensions._postgis_index_extent | box2d | tbl regclass, col text | FUNCTION |
| extensions.gserialized_gist_sel_2d | float8 | internal, oid, internal, integer | FUNCTION |
| extensions.gserialized_gist_sel_nd | float8 | internal, oid, internal, integer | FUNCTION |
| extensions.gserialized_gist_joinsel_2d | float8 | internal, oid, internal, smallint | FUNCTION |
| extensions.gserialized_gist_joinsel_nd | float8 | internal, oid, internal, smallint | FUNCTION |
| extensions.geometry_overlaps | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_same | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_distance_centroid | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_distance_box | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_contains | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_geomfromewkt | geometry | text | FUNCTION |
| supabase_functions.http_request | trigger |  | FUNCTION |
| graphql_public.graphql | jsonb | "operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb | FUNCTION |
| graphql.resolve | jsonb | query text, variables jsonb DEFAULT '{}'::jsonb, "operationName" text DEFAULT NULL::text, extensions jsonb DEFAULT NULL::jsonb | FUNCTION |
| graphql.comment_directive | jsonb | comment_ text | FUNCTION |
| graphql.exception | text | message text | FUNCTION |
| graphql.sequential_executor | jsonb | prepared_statement_names text[] | FUNCTION |
| graphql.increment_schema_version | event_trigger |  | FUNCTION |
| graphql.get_schema_version | int4 |  | FUNCTION |
| extensions._postgis_deprecate | void | oldname text, newname text, version text | FUNCTION |
| extensions.spheroid_in | spheroid | cstring | FUNCTION |
| extensions.spheroid_out | cstring | spheroid | FUNCTION |
| extensions.geometry_in | geometry | cstring | FUNCTION |
| extensions.geometry_out | cstring | geometry | FUNCTION |
| extensions.geometry_typmod_in | int4 | cstring[] | FUNCTION |
| extensions.st_expand | geometry | geom geometry, dx double precision, dy double precision, dz double precision DEFAULT 0, dm double precision DEFAULT 0 | FUNCTION |
| extensions.st_envelope | geometry | geometry | FUNCTION |
| extensions.st_boundingdiagonal | geometry | geom geometry, fits boolean DEFAULT false | FUNCTION |
| extensions.st_reverse | geometry | geometry | FUNCTION |
| extensions.st_forcepolygoncw | geometry | geometry | FUNCTION |
| extensions.st_forcepolygonccw | geometry | geometry | FUNCTION |
| extensions.st_forcerhr | geometry | geometry | FUNCTION |
| extensions.postgis_noop | geometry | geometry | FUNCTION |
| extensions.postgis_geos_noop | geometry | geometry | FUNCTION |
| extensions.st_normalize | geometry | geom geometry | FUNCTION |
| extensions.st_zmflag | int2 | geometry | FUNCTION |
| extensions.st_ndims | int2 | geometry | FUNCTION |
| extensions.st_asewkt | text | geometry | FUNCTION |
| extensions.st_asewkt | text | geometry, integer | FUNCTION |
| extensions.st_astwkb | bytea | geom geometry, prec integer DEFAULT NULL::integer, prec_z integer DEFAULT NULL::integer, prec_m integer DEFAULT NULL::integer, with_sizes boolean DEFAULT NULL::boolean, with_boxes boolean DEFAULT NULL::boolean | FUNCTION |
| extensions.st_astwkb | bytea | geom geometry[], ids bigint[], prec integer DEFAULT NULL::integer, prec_z integer DEFAULT NULL::integer, prec_m integer DEFAULT NULL::integer, with_sizes boolean DEFAULT NULL::boolean, with_boxes boolean DEFAULT NULL::boolean | FUNCTION |
| extensions.st_asewkb | bytea | geometry | FUNCTION |
| extensions.st_ashexewkb | text | geometry | FUNCTION |
| extensions.st_ashexewkb | text | geometry, text | FUNCTION |
| extensions.st_asewkb | bytea | geometry, text | FUNCTION |
| extensions.st_aslatlontext | text | geom geometry, tmpl text DEFAULT ''::text | FUNCTION |
| extensions.geomfromewkb | geometry | bytea | FUNCTION |
| extensions.st_geomfromewkb | geometry | bytea | FUNCTION |
| extensions.st_geomfromtwkb | geometry | bytea | FUNCTION |
| extensions.geomfromewkt | geometry | text | FUNCTION |
| extensions.st_dump | geometry_dump | geometry | FUNCTION |
| extensions.st_dumprings | geometry_dump | geometry | FUNCTION |
| extensions.st_dumppoints | geometry_dump | geometry | FUNCTION |
| extensions.populate_geometry_columns | text | use_typmod boolean DEFAULT true | FUNCTION |
| extensions.populate_geometry_columns | int4 | tbl_oid oid, use_typmod boolean DEFAULT true | FUNCTION |
| extensions.addgeometrycolumn | text | catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean DEFAULT true | FUNCTION |
| extensions.addgeometrycolumn | text | schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean DEFAULT true | FUNCTION |
| extensions.addgeometrycolumn | text | table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean DEFAULT true | FUNCTION |
| extensions.dropgeometrycolumn | text | catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying | FUNCTION |
| extensions.dropgeometrycolumn | text | schema_name character varying, table_name character varying, column_name character varying | FUNCTION |
| extensions.dropgeometrycolumn | text | table_name character varying, column_name character varying | FUNCTION |
| extensions.dropgeometrytable | text | catalog_name character varying, schema_name character varying, table_name character varying | FUNCTION |
| extensions.dropgeometrytable | text | schema_name character varying, table_name character varying | FUNCTION |
| extensions.dropgeometrytable | text | table_name character varying | FUNCTION |
| extensions.updategeometrysrid | text | catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer | FUNCTION |
| extensions.updategeometrysrid | text | character varying, character varying, character varying, integer | FUNCTION |
| extensions.updategeometrysrid | text | character varying, character varying, integer | FUNCTION |
| extensions.find_srid | int4 | character varying, character varying, character varying | FUNCTION |
| extensions.get_proj4_from_srid | text | integer | FUNCTION |
| extensions.st_setsrid | geometry | geom geometry, srid integer | FUNCTION |
| extensions.st_srid | int4 | geom geometry | FUNCTION |
| extensions.postgis_transform_geometry | geometry | geom geometry, text, text, integer | FUNCTION |
| extensions.st_transform | geometry | geometry, integer | FUNCTION |
| extensions.st_transform | geometry | geom geometry, to_proj text | FUNCTION |
| extensions.st_transform | geometry | geom geometry, from_proj text, to_proj text | FUNCTION |
| extensions.st_transform | geometry | geom geometry, from_proj text, to_srid integer | FUNCTION |
| extensions.postgis_version | text |  | FUNCTION |
| extensions.postgis_liblwgeom_version | text |  | FUNCTION |
| extensions.postgis_proj_version | text |  | FUNCTION |
| extensions.postgis_wagyu_version | text |  | FUNCTION |
| extensions.postgis_scripts_installed | text |  | FUNCTION |
| extensions.postgis_lib_version | text |  | FUNCTION |
| extensions.postgis_scripts_released | text |  | FUNCTION |
| extensions.postgis_geos_version | text |  | FUNCTION |
| extensions.postgis_lib_revision | text |  | FUNCTION |
| extensions.postgis_svn_version | text |  | FUNCTION |
| extensions.postgis_libxml_version | text |  | FUNCTION |
| extensions.postgis_scripts_build_date | text |  | FUNCTION |
| extensions.postgis_lib_build_date | text |  | FUNCTION |
| extensions._postgis_scripts_pgsql_version | text |  | FUNCTION |
| extensions._postgis_pgsql_version | text |  | FUNCTION |
| extensions.postgis_extensions_upgrade | text |  | FUNCTION |
| extensions.postgis_full_version | text |  | FUNCTION |
| extensions.box2d | box2d | geometry | FUNCTION |
| extensions.box3d | box3d | geometry | FUNCTION |
| extensions.box | box | geometry | FUNCTION |
| extensions.box2d | box2d | box3d | FUNCTION |
| extensions.box3d | box3d | box2d | FUNCTION |
| extensions.box | box | box3d | FUNCTION |
| extensions.text | text | geometry | FUNCTION |
| extensions.box3dtobox | box | box3d | FUNCTION |
| extensions.geometry | geometry | box2d | FUNCTION |
| extensions.geometry | geometry | box3d | FUNCTION |
| extensions.geometry | geometry | text | FUNCTION |
| extensions.geometry | geometry | bytea | FUNCTION |
| extensions.bytea | bytea | geometry | FUNCTION |
| extensions.st_simplify | geometry | geometry, double precision | FUNCTION |
| extensions.st_simplify | geometry | geometry, double precision, boolean | FUNCTION |
| extensions.st_simplifyvw | geometry | geometry, double precision | FUNCTION |
| extensions.st_generatepoints | geometry | area geometry, npoints integer | FUNCTION |
| extensions.st_generatepoints | geometry | area geometry, npoints integer, seed integer | FUNCTION |
| extensions.st_seteffectivearea | geometry | geometry, double precision DEFAULT '-1'::integer, integer DEFAULT 1 | FUNCTION |
| extensions.st_filterbym | geometry | geometry, double precision, double precision DEFAULT NULL::double precision, boolean DEFAULT false | FUNCTION |
| extensions.st_chaikinsmoothing | geometry | geometry, integer DEFAULT 1, boolean DEFAULT false | FUNCTION |
| extensions.st_snaptogrid | geometry | geometry, double precision, double precision, double precision, double precision | FUNCTION |
| extensions.st_snaptogrid | geometry | geometry, double precision, double precision | FUNCTION |
| extensions.st_snaptogrid | geometry | geometry, double precision | FUNCTION |
| extensions.st_snaptogrid | geometry | geom1 geometry, geom2 geometry, double precision, double precision, double precision, double precision | FUNCTION |
| extensions.st_segmentize | geometry | geometry, double precision | FUNCTION |
| extensions.st_lineinterpolatepoint | geometry | geometry, double precision | FUNCTION |
| extensions.st_lineinterpolatepoints | geometry | geometry, double precision, repeat boolean DEFAULT true | FUNCTION |
| extensions.st_linesubstring | geometry | geometry, double precision, double precision | FUNCTION |
| extensions.st_linelocatepoint | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_addmeasure | geometry | geometry, double precision, double precision | FUNCTION |
| extensions.st_closestpointofapproach | float8 | geometry, geometry | FUNCTION |
| extensions.st_distancecpa | float8 | geometry, geometry | FUNCTION |
| extensions.st_cpawithin | bool | geometry, geometry, double precision | FUNCTION |
| extensions.st_isvalidtrajectory | bool | geometry | FUNCTION |
| extensions.st_intersection | geometry | geom1 geometry, geom2 geometry, gridsize double precision DEFAULT '-1'::integer | FUNCTION |
| extensions.st_buffer | geometry | geom geometry, radius double precision, options text DEFAULT ''::text | FUNCTION |
| extensions.st_buffer | geometry | geom geometry, radius double precision, quadsegs integer | FUNCTION |
| extensions.st_minimumboundingradius | record | geometry, OUT center geometry, OUT radius double precision | FUNCTION |
| extensions.st_minimumboundingcircle | geometry | inputgeom geometry, segs_per_quarter integer DEFAULT 48 | FUNCTION |
| extensions.st_orientedenvelope | geometry | geometry | FUNCTION |
| extensions.st_offsetcurve | geometry | line geometry, distance double precision, params text DEFAULT ''::text | FUNCTION |
| extensions.st_convexhull | geometry | geometry | FUNCTION |
| extensions.st_simplifypreservetopology | geometry | geometry, double precision | FUNCTION |
| extensions.st_isvalidreason | text | geometry | FUNCTION |
| extensions.st_isvaliddetail | valid_detail | geom geometry, flags integer DEFAULT 0 | FUNCTION |
| extensions.st_isvalidreason | text | geometry, integer | FUNCTION |
| extensions.st_isvalid | bool | geometry, integer | FUNCTION |
| extensions.st_hausdorffdistance | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_hausdorffdistance | float8 | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions.st_frechetdistance | float8 | geom1 geometry, geom2 geometry, double precision DEFAULT '-1'::integer | FUNCTION |
| extensions.st_maximuminscribedcircle | record | geometry, OUT center geometry, OUT nearest geometry, OUT radius double precision | FUNCTION |
| extensions.st_difference | geometry | geom1 geometry, geom2 geometry, gridsize double precision DEFAULT '-1.0'::numeric | FUNCTION |
| extensions.st_boundary | geometry | geometry | FUNCTION |
| extensions.st_points | geometry | geometry | FUNCTION |
| extensions.st_symdifference | geometry | geom1 geometry, geom2 geometry, gridsize double precision DEFAULT '-1.0'::numeric | FUNCTION |
| extensions.st_symmetricdifference | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_union | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_union | geometry | geom1 geometry, geom2 geometry, gridsize double precision | FUNCTION |
| extensions.st_unaryunion | geometry | geometry, gridsize double precision DEFAULT '-1.0'::numeric | FUNCTION |
| extensions.st_removerepeatedpoints | geometry | geom geometry, tolerance double precision DEFAULT 0.0 | FUNCTION |
| extensions.st_clipbybox2d | geometry | geom geometry, box box2d | FUNCTION |
| extensions.st_subdivide | geometry | geom geometry, maxvertices integer DEFAULT 256, gridsize double precision DEFAULT '-1.0'::numeric | FUNCTION |
| extensions.st_reduceprecision | geometry | geom geometry, gridsize double precision | FUNCTION |
| extensions.st_makevalid | geometry | geometry | FUNCTION |
| extensions.st_cleangeometry | geometry | geometry | FUNCTION |
| extensions.st_split | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_sharedpaths | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_snap | geometry | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions.st_relatematch | bool | text, text | FUNCTION |
| extensions.st_node | geometry | g geometry | FUNCTION |
| extensions.st_delaunaytriangles | geometry | g1 geometry, tolerance double precision DEFAULT 0.0, flags integer DEFAULT 0 | FUNCTION |
| extensions._st_voronoi | geometry | g1 geometry, clip geometry DEFAULT NULL::geometry, tolerance double precision DEFAULT 0.0, return_polygons boolean DEFAULT true | FUNCTION |
| extensions.st_voronoipolygons | geometry | g1 geometry, tolerance double precision DEFAULT 0.0, extend_to geometry DEFAULT NULL::geometry | FUNCTION |
| extensions.st_voronoilines | geometry | g1 geometry, tolerance double precision DEFAULT 0.0, extend_to geometry DEFAULT NULL::geometry | FUNCTION |
| extensions.st_combinebbox | box3d | box3d, geometry | FUNCTION |
| extensions.st_combinebbox | box3d | box3d, box3d | FUNCTION |
| extensions.st_combinebbox | box2d | box2d, geometry | FUNCTION |
| extensions.st_extent | box2d | geometry | a |
| extensions.st_3dextent | box3d | geometry | a |
| extensions.st_collect | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_memcollect | geometry | geometry | a |
| extensions.st_collect | geometry | geometry[] | FUNCTION |
| extensions.st_memunion | geometry | geometry | a |
| extensions.pgis_geometry_accum_transfn | internal | internal, geometry | FUNCTION |
| extensions.pgis_geometry_accum_transfn | internal | internal, geometry, double precision | FUNCTION |
| extensions.pgis_geometry_accum_transfn | internal | internal, geometry, double precision, integer | FUNCTION |
| extensions.pgis_geometry_union_finalfn | geometry | internal | FUNCTION |
| extensions.pgis_geometry_collect_finalfn | geometry | internal | FUNCTION |
| extensions.pgis_geometry_polygonize_finalfn | geometry | internal | FUNCTION |
| extensions.pgis_geometry_clusterintersecting_finalfn | _geometry | internal | FUNCTION |
| extensions.pgis_geometry_clusterwithin_finalfn | _geometry | internal | FUNCTION |
| extensions.pgis_geometry_makeline_finalfn | geometry | internal | FUNCTION |
| extensions.st_union | geometry | geometry[] | FUNCTION |
| extensions.st_union | geometry | geometry | a |
| extensions.st_union | geometry | geometry, gridsize double precision | a |
| extensions.st_collect | geometry | geometry | a |
| extensions.st_clusterintersecting | _geometry | geometry | a |
| extensions.st_clusterwithin | _geometry | geometry, double precision | a |
| extensions.st_polygonize | geometry | geometry | a |
| extensions.st_makeline | geometry | geometry | a |
| extensions.st_clusterkmeans | int4 | geom geometry, k integer | w |
| extensions.st_relate | text | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_relate | text | geom1 geometry, geom2 geometry, integer | FUNCTION |
| extensions.st_relate | bool | geom1 geometry, geom2 geometry, text | FUNCTION |
| extensions.st_disjoint | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_linecrossingdirection | int4 | line1 geometry, line2 geometry | FUNCTION |
| extensions._st_dwithin | bool | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions._st_touches | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_intersects | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_crosses | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_contains | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_containsproperly | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_covers | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_coveredby | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_within | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_overlaps | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_dfullywithin | bool | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions._st_3ddwithin | bool | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions._st_3ddfullywithin | bool | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions._st_3dintersects | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_orderingequals | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_equals | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.postgis_index_supportfn | internal | internal | FUNCTION |
| extensions.st_linecrossingdirection | int4 | line1 geometry, line2 geometry | FUNCTION |
| extensions.st_dwithin | bool | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions.st_touches | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_intersects | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_crosses | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_contains | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_containsproperly | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_within | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_covers | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_coveredby | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_overlaps | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_dfullywithin | bool | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions.st_3ddwithin | bool | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions.st_3ddfullywithin | bool | geom1 geometry, geom2 geometry, double precision | FUNCTION |
| extensions.st_3dintersects | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_orderingequals | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_equals | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_isvalid | bool | geometry | FUNCTION |
| extensions.st_minimumclearance | float8 | geometry | FUNCTION |
| extensions.st_minimumclearanceline | geometry | geometry | FUNCTION |
| extensions.st_centroid | geometry | geometry | FUNCTION |
| extensions.st_geometricmedian | geometry | g geometry, tolerance double precision DEFAULT NULL::double precision, max_iter integer DEFAULT 10000, fail_if_not_converged boolean DEFAULT false | FUNCTION |
| extensions.st_isring | bool | geometry | FUNCTION |
| extensions.st_pointonsurface | geometry | geometry | FUNCTION |
| extensions.st_issimple | bool | geometry | FUNCTION |
| extensions.st_iscollection | bool | geometry | FUNCTION |
| extensions.equals | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_geomfromgml | geometry | text, integer | FUNCTION |
| extensions.st_geomfromgml | geometry | text, integer | FUNCTION |
| extensions.st_geomfromgml | geometry | text | FUNCTION |
| extensions.st_gmltosql | geometry | text | FUNCTION |
| extensions.st_gmltosql | geometry | text, integer | FUNCTION |
| extensions.st_geomfromkml | geometry | text | FUNCTION |
| extensions.st_geomfromgeojson | geometry | text | FUNCTION |
| extensions.st_geomfromgeojson | geometry | json | FUNCTION |
| extensions.st_geomfromgeojson | geometry | jsonb | FUNCTION |
| extensions.postgis_libjson_version | text |  | FUNCTION |
| extensions.st_linefromencodedpolyline | geometry | txtin text, nprecision integer DEFAULT 5 | FUNCTION |
| extensions.st_asencodedpolyline | text | geom geometry, nprecision integer DEFAULT 5 | FUNCTION |
| extensions.st_assvg | text | geom geometry, rel integer DEFAULT 0, maxdecimaldigits integer DEFAULT 15 | FUNCTION |
| extensions._st_asgml | text | integer, geometry, integer, integer, text, text | FUNCTION |
| extensions.st_asgml | text | geom geometry, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0 | FUNCTION |
| extensions.st_asgml | text | version integer, geom geometry, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0, nprefix text DEFAULT NULL::text, id text DEFAULT NULL::text | FUNCTION |
| extensions.st_askml | text | geom geometry, maxdecimaldigits integer DEFAULT 15, nprefix text DEFAULT ''::text | FUNCTION |
| extensions.st_asgeojson | text | geom geometry, maxdecimaldigits integer DEFAULT 9, options integer DEFAULT 8 | FUNCTION |
| extensions.st_asgeojson | text | r record, geom_column text DEFAULT ''::text, maxdecimaldigits integer DEFAULT 9, pretty_bool boolean DEFAULT false | FUNCTION |
| extensions.json | json | geometry | FUNCTION |
| extensions.jsonb | jsonb | geometry | FUNCTION |
| extensions.pgis_asmvt_transfn | internal | internal, anyelement | FUNCTION |
| extensions.pgis_asmvt_transfn | internal | internal, anyelement, text | FUNCTION |
| extensions.pgis_asmvt_transfn | internal | internal, anyelement, text, integer | FUNCTION |
| extensions.pgis_asmvt_transfn | internal | internal, anyelement, text, integer, text | FUNCTION |
| extensions.pgis_asmvt_transfn | internal | internal, anyelement, text, integer, text, text | FUNCTION |
| extensions.pgis_asmvt_finalfn | bytea | internal | FUNCTION |
| extensions.pgis_asmvt_combinefn | internal | internal, internal | FUNCTION |
| extensions.pgis_asmvt_serialfn | bytea | internal | FUNCTION |
| extensions.pgis_asmvt_deserialfn | internal | bytea, internal | FUNCTION |
| extensions.st_asmvt | bytea | anyelement | a |
| extensions.st_asmvt | bytea | anyelement, text | a |
| extensions.st_asmvt | bytea | anyelement, text, integer | a |
| extensions.st_asmvt | bytea | anyelement, text, integer, text | a |
| extensions.st_asmvt | bytea | anyelement, text, integer, text, text | a |
| extensions.st_asmvtgeom | geometry | geom geometry, bounds box2d, extent integer DEFAULT 4096, buffer integer DEFAULT 256, clip_geom boolean DEFAULT true | FUNCTION |
| extensions.postgis_libprotobuf_version | text |  | FUNCTION |
| extensions.pgis_asgeobuf_transfn | internal | internal, anyelement | FUNCTION |
| extensions.pgis_asgeobuf_transfn | internal | internal, anyelement, text | FUNCTION |
| extensions.pgis_asgeobuf_finalfn | bytea | internal | FUNCTION |
| extensions.st_asgeobuf | bytea | anyelement | a |
| extensions.st_asgeobuf | bytea | anyelement, text | a |
| extensions.st_geohash | text | geom geometry, maxchars integer DEFAULT 0 | FUNCTION |
| extensions._st_sortablehash | int8 | geom geometry | FUNCTION |
| extensions.st_box2dfromgeohash | box2d | text, integer DEFAULT NULL::integer | FUNCTION |
| extensions.st_pointfromgeohash | geometry | text, integer DEFAULT NULL::integer | FUNCTION |
| extensions.st_geomfromgeohash | geometry | text, integer DEFAULT NULL::integer | FUNCTION |
| extensions.st_numpoints | int4 | geometry | FUNCTION |
| extensions.st_numgeometries | int4 | geometry | FUNCTION |
| extensions.st_geometryn | geometry | geometry, integer | FUNCTION |
| extensions.st_dimension | int4 | geometry | FUNCTION |
| extensions.st_exteriorring | geometry | geometry | FUNCTION |
| extensions.st_numinteriorrings | int4 | geometry | FUNCTION |
| extensions.st_numinteriorring | int4 | geometry | FUNCTION |
| extensions.st_interiorringn | geometry | geometry, integer | FUNCTION |
| extensions.geometrytype | text | geometry | FUNCTION |
| extensions.st_geometrytype | text | geometry | FUNCTION |
| extensions.st_pointn | geometry | geometry, integer | FUNCTION |
| extensions.st_numpatches | int4 | geometry | FUNCTION |
| extensions.st_patchn | geometry | geometry, integer | FUNCTION |
| extensions.st_startpoint | geometry | geometry | FUNCTION |
| extensions.st_endpoint | geometry | geometry | FUNCTION |
| extensions.st_isclosed | bool | geometry | FUNCTION |
| extensions.st_isempty | bool | geometry | FUNCTION |
| extensions.st_asbinary | bytea | geometry, text | FUNCTION |
| extensions.st_asbinary | bytea | geometry | FUNCTION |
| extensions.st_astext | text | geometry | FUNCTION |
| extensions.st_astext | text | geometry, integer | FUNCTION |
| extensions.st_geometryfromtext | geometry | text | FUNCTION |
| extensions.st_geometryfromtext | geometry | text, integer | FUNCTION |
| extensions.st_geomfromtext | geometry | text | FUNCTION |
| extensions.st_geomfromtext | geometry | text, integer | FUNCTION |
| extensions.st_wkttosql | geometry | text | FUNCTION |
| extensions.st_pointfromtext | geometry | text | FUNCTION |
| extensions.st_pointfromtext | geometry | text, integer | FUNCTION |
| extensions.st_linefromtext | geometry | text | FUNCTION |
| extensions.st_linefromtext | geometry | text, integer | FUNCTION |
| extensions.st_polyfromtext | geometry | text | FUNCTION |
| extensions.st_polyfromtext | geometry | text, integer | FUNCTION |
| extensions.st_polygonfromtext | geometry | text, integer | FUNCTION |
| extensions.st_polygonfromtext | geometry | text | FUNCTION |
| extensions.st_mlinefromtext | geometry | text, integer | FUNCTION |
| extensions.st_mlinefromtext | geometry | text | FUNCTION |
| extensions.st_multilinestringfromtext | geometry | text | FUNCTION |
| extensions.st_multilinestringfromtext | geometry | text, integer | FUNCTION |
| extensions.st_mpointfromtext | geometry | text, integer | FUNCTION |
| extensions.st_mpointfromtext | geometry | text | FUNCTION |
| extensions.st_multipointfromtext | geometry | text | FUNCTION |
| extensions.st_geogfromwkb | geography | bytea | FUNCTION |
| extensions.st_mpolyfromtext | geometry | text, integer | FUNCTION |
| extensions.st_mpolyfromtext | geometry | text | FUNCTION |
| extensions.st_multipolygonfromtext | geometry | text, integer | FUNCTION |
| extensions.st_multipolygonfromtext | geometry | text | FUNCTION |
| extensions.st_geomcollfromtext | geometry | text, integer | FUNCTION |
| extensions.st_geomcollfromtext | geometry | text | FUNCTION |
| extensions.st_geomfromwkb | geometry | bytea | FUNCTION |
| extensions.st_geomfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_pointfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_pointfromwkb | geometry | bytea | FUNCTION |
| extensions.st_linefromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_linefromwkb | geometry | bytea | FUNCTION |
| extensions.st_linestringfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_linestringfromwkb | geometry | bytea | FUNCTION |
| extensions.st_polyfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_polyfromwkb | geometry | bytea | FUNCTION |
| extensions.st_polygonfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_polygonfromwkb | geometry | bytea | FUNCTION |
| extensions.st_mpointfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_mpointfromwkb | geometry | bytea | FUNCTION |
| extensions.st_multipointfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_multipointfromwkb | geometry | bytea | FUNCTION |
| extensions.st_multilinefromwkb | geometry | bytea | FUNCTION |
| extensions.st_mlinefromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_mlinefromwkb | geometry | bytea | FUNCTION |
| extensions.postgis_typmod_dims | int4 | integer | FUNCTION |
| extensions.st_mpolyfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_mpolyfromwkb | geometry | bytea | FUNCTION |
| extensions.st_multipolyfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_multipolyfromwkb | geometry | bytea | FUNCTION |
| extensions.st_geomcollfromwkb | geometry | bytea, integer | FUNCTION |
| extensions.st_geomcollfromwkb | geometry | bytea | FUNCTION |
| extensions._st_maxdistance | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_maxdistance | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_closestpoint | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_shortestline | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions._st_longestline | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_longestline | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_swapordinates | geometry | geom geometry, ords cstring | FUNCTION |
| extensions.st_flipcoordinates | geometry | geometry | FUNCTION |
| extensions.st_bdpolyfromtext | geometry | text, integer | FUNCTION |
| extensions.st_bdmpolyfromtext | geometry | text, integer | FUNCTION |
| extensions.unlockrows | int4 | text | FUNCTION |
| extensions.lockrow | int4 | text, text, text, text, timestamp without time zone | FUNCTION |
| extensions.lockrow | int4 | text, text, text, text | FUNCTION |
| extensions.lockrow | int4 | text, text, text | FUNCTION |
| extensions.lockrow | int4 | text, text, text, timestamp without time zone | FUNCTION |
| extensions.postgis_typmod_srid | int4 | integer | FUNCTION |
| extensions.addauth | bool | text | FUNCTION |
| extensions.checkauth | int4 | text, text, text | FUNCTION |
| extensions.checkauth | int4 | text, text | FUNCTION |
| extensions.checkauthtrigger | trigger |  | FUNCTION |
| extensions.gettransactionid | xid |  | FUNCTION |
| extensions.enablelongtransactions | text |  | FUNCTION |
| extensions.longtransactionsenabled | bool |  | FUNCTION |
| extensions.disablelongtransactions | text |  | FUNCTION |
| extensions.geography_typmod_in | int4 | cstring[] | FUNCTION |
| extensions.geography_typmod_out | cstring | integer | FUNCTION |
| extensions.geography_in | geography | cstring, oid, integer | FUNCTION |
| extensions.geography_out | cstring | geography | FUNCTION |
| extensions.geography_recv | geography | internal, oid, integer | FUNCTION |
| extensions.geography_send | bytea | geography | FUNCTION |
| extensions.geography_analyze | bool | internal | FUNCTION |
| extensions.geography | geography | geography, integer, boolean | FUNCTION |
| extensions.geography | geography | bytea | FUNCTION |
| extensions.bytea | bytea | geography | FUNCTION |
| extensions.st_astext | text | geography | FUNCTION |
| extensions.st_astext | text | geography, integer | FUNCTION |
| extensions.st_astext | text | text | FUNCTION |
| extensions.st_geographyfromtext | geography | text | FUNCTION |
| extensions.st_geogfromtext | geography | text | FUNCTION |
| extensions.postgis_typmod_type | text | integer | FUNCTION |
| extensions.geography | geography | geometry | FUNCTION |
| extensions.geometry | geometry | geography | FUNCTION |
| extensions.geography_gist_consistent | bool | internal, geography, integer | FUNCTION |
| extensions.geography_gist_compress | internal | internal | FUNCTION |
| extensions.geography_gist_penalty | internal | internal, internal, internal | FUNCTION |
| extensions.geography_gist_picksplit | internal | internal, internal | FUNCTION |
| extensions.geography_gist_union | internal | bytea, internal | FUNCTION |
| extensions.geography_gist_same | internal | box2d, box2d, internal | FUNCTION |
| extensions.geography_gist_decompress | internal | internal | FUNCTION |
| extensions.geography_overlaps | bool | geography, geography | FUNCTION |
| extensions.geography_distance_knn | float8 | geography, geography | FUNCTION |
| extensions.geography_gist_distance | float8 | internal, geography, integer | FUNCTION |
| extensions.overlaps_geog | bool | gidx, geography | FUNCTION |
| extensions.overlaps_geog | bool | gidx, gidx | FUNCTION |
| extensions.overlaps_geog | bool | geography, gidx | FUNCTION |
| extensions.geog_brin_inclusion_add_value | bool | internal, internal, internal, internal | FUNCTION |
| extensions.geography_lt | bool | geography, geography | FUNCTION |
| extensions.geography_le | bool | geography, geography | FUNCTION |
| extensions.geography_gt | bool | geography, geography | FUNCTION |
| extensions.geography_ge | bool | geography, geography | FUNCTION |
| extensions.geography_eq | bool | geography, geography | FUNCTION |
| extensions.geography_cmp | int4 | geography, geography | FUNCTION |
| extensions.st_assvg | text | geog geography, rel integer DEFAULT 0, maxdecimaldigits integer DEFAULT 15 | FUNCTION |
| extensions.st_assvg | text | text | FUNCTION |
| extensions.st_asgml | text | version integer, geog geography, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0, nprefix text DEFAULT 'gml'::text, id text DEFAULT ''::text | FUNCTION |
| extensions.st_asgml | text | geog geography, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0, nprefix text DEFAULT 'gml'::text, id text DEFAULT ''::text | FUNCTION |
| extensions.st_asgml | text | text | FUNCTION |
| extensions.st_askml | text | geog geography, maxdecimaldigits integer DEFAULT 15, nprefix text DEFAULT ''::text | FUNCTION |
| extensions.st_askml | text | text | FUNCTION |
| extensions.st_asgeojson | text | geog geography, maxdecimaldigits integer DEFAULT 9, options integer DEFAULT 0 | FUNCTION |
| extensions.st_asgeojson | text | text | FUNCTION |
| extensions.st_distance | float8 | geog1 geography, geog2 geography, use_spheroid boolean DEFAULT true | FUNCTION |
| extensions.st_distance | float8 | text, text | FUNCTION |
| extensions._st_expand | geography | geography, double precision | FUNCTION |
| extensions._st_distanceuncached | float8 | geography, geography, double precision, boolean | FUNCTION |
| extensions._st_distanceuncached | float8 | geography, geography, boolean | FUNCTION |
| extensions._st_distanceuncached | float8 | geography, geography | FUNCTION |
| extensions._st_distancetree | float8 | geography, geography, double precision, boolean | FUNCTION |
| extensions._st_distancetree | float8 | geography, geography | FUNCTION |
| extensions._st_dwithinuncached | bool | geography, geography, double precision, boolean | FUNCTION |
| extensions._st_dwithinuncached | bool | geography, geography, double precision | FUNCTION |
| extensions.st_area | float8 | geog geography, use_spheroid boolean DEFAULT true | FUNCTION |
| extensions.st_area | float8 | text | FUNCTION |
| extensions.st_length | float8 | geog geography, use_spheroid boolean DEFAULT true | FUNCTION |
| extensions.st_length | float8 | text | FUNCTION |
| extensions.st_project | geography | geog geography, distance double precision, azimuth double precision | FUNCTION |
| extensions.st_azimuth | float8 | geog1 geography, geog2 geography | FUNCTION |
| extensions.st_perimeter | float8 | geog geography, use_spheroid boolean DEFAULT true | FUNCTION |
| extensions._st_pointoutside | geography | geography | FUNCTION |
| extensions.st_segmentize | geography | geog geography, max_segment_length double precision | FUNCTION |
| extensions._st_bestsrid | int4 | geography, geography | FUNCTION |
| extensions._st_bestsrid | int4 | geography | FUNCTION |
| extensions.st_buffer | geography | geography, double precision | FUNCTION |
| extensions.st_buffer | geography | geography, double precision, integer | FUNCTION |
| extensions.st_buffer | geography | geography, double precision, text | FUNCTION |
| extensions.st_buffer | geometry | text, double precision | FUNCTION |
| extensions.st_buffer | geometry | text, double precision, integer | FUNCTION |
| extensions.st_buffer | geometry | text, double precision, text | FUNCTION |
| extensions.st_intersection | geography | geography, geography | FUNCTION |
| extensions.st_intersection | geometry | text, text | FUNCTION |
| extensions.st_asbinary | bytea | geography | FUNCTION |
| extensions.st_asbinary | bytea | geography, text | FUNCTION |
| extensions.st_asewkt | text | geography | FUNCTION |
| extensions.st_asewkt | text | geography, integer | FUNCTION |
| extensions.st_asewkt | text | text | FUNCTION |
| extensions.geometrytype | text | geography | FUNCTION |
| extensions.st_summary | text | geography | FUNCTION |
| extensions.st_geohash | text | geog geography, maxchars integer DEFAULT 0 | FUNCTION |
| extensions.st_srid | int4 | geog geography | FUNCTION |
| extensions.st_setsrid | geography | geog geography, srid integer | FUNCTION |
| extensions.st_centroid | geography | geography, use_spheroid boolean DEFAULT true | FUNCTION |
| extensions.st_centroid | geometry | text | FUNCTION |
| extensions._st_covers | bool | geog1 geography, geog2 geography | FUNCTION |
| extensions._st_dwithin | bool | geog1 geography, geog2 geography, tolerance double precision, use_spheroid boolean DEFAULT true | FUNCTION |
| extensions._st_coveredby | bool | geog1 geography, geog2 geography | FUNCTION |
| extensions.st_covers | bool | geog1 geography, geog2 geography | FUNCTION |
| extensions.st_dwithin | bool | geog1 geography, geog2 geography, tolerance double precision, use_spheroid boolean DEFAULT true | FUNCTION |
| extensions.st_coveredby | bool | geog1 geography, geog2 geography | FUNCTION |
| extensions.st_intersects | bool | geog1 geography, geog2 geography | FUNCTION |
| extensions.st_covers | bool | text, text | FUNCTION |
| extensions.st_coveredby | bool | text, text | FUNCTION |
| extensions.st_dwithin | bool | text, text, double precision | FUNCTION |
| extensions.st_intersects | bool | text, text | FUNCTION |
| extensions.st_distancesphere | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.postgis_type_name | varchar | geomname character varying, coord_dimension integer, use_new_name boolean DEFAULT true | FUNCTION |
| extensions.postgis_constraint_srid | int4 | geomschema text, geomtable text, geomcolumn text | FUNCTION |
| extensions.postgis_constraint_dims | int4 | geomschema text, geomtable text, geomcolumn text | FUNCTION |
| extensions.postgis_constraint_type | varchar | geomschema text, geomtable text, geomcolumn text | FUNCTION |
| extensions.st_3ddistance | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_3dmaxdistance | float8 | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_3dclosestpoint | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_3dshortestline | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_3dlongestline | geometry | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.st_coorddim | int2 | geometry geometry | FUNCTION |
| extensions.st_curvetoline | geometry | geom geometry, tol double precision DEFAULT 32, toltype integer DEFAULT 0, flags integer DEFAULT 0 | FUNCTION |
| extensions.st_hasarc | bool | geometry geometry | FUNCTION |
| extensions.st_linetocurve | geometry | geometry geometry | FUNCTION |
| extensions.st_point | geometry | double precision, double precision | FUNCTION |
| extensions.st_polygon | geometry | geometry, integer | FUNCTION |
| extensions.st_wkbtosql | geometry | wkb bytea | FUNCTION |
| extensions.geometry_spgist_leaf_consistent_nd | bool | internal, internal | FUNCTION |
| extensions.st_locatebetween | geometry | geometry geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision DEFAULT 0.0 | FUNCTION |
| extensions.st_locatealong | geometry | geometry geometry, measure double precision, leftrightoffset double precision DEFAULT 0.0 | FUNCTION |
| extensions.st_locatebetweenelevations | geometry | geometry geometry, fromelevation double precision, toelevation double precision | FUNCTION |
| extensions.st_interpolatepoint | float8 | line geometry, point geometry | FUNCTION |
| extensions.st_hexagon | geometry | size double precision, cell_i integer, cell_j integer, origin geometry DEFAULT '010100000000000000000000000000000000000000'::geometry | FUNCTION |
| extensions.st_square | geometry | size double precision, cell_i integer, cell_j integer, origin geometry DEFAULT '010100000000000000000000000000000000000000'::geometry | FUNCTION |
| extensions.st_hexagongrid | record | size double precision, bounds geometry, OUT geom geometry, OUT i integer, OUT j integer | FUNCTION |
| extensions.st_squaregrid | record | size double precision, bounds geometry, OUT geom geometry, OUT i integer, OUT j integer | FUNCTION |
| extensions.contains_2d | bool | box2df, geometry | FUNCTION |
| extensions.is_contained_2d | bool | box2df, geometry | FUNCTION |
| extensions.overlaps_2d | bool | box2df, geometry | FUNCTION |
| extensions.overlaps_2d | bool | box2df, box2df | FUNCTION |
| extensions.contains_2d | bool | box2df, box2df | FUNCTION |
| extensions.is_contained_2d | bool | box2df, box2df | FUNCTION |
| extensions.contains_2d | bool | geometry, box2df | FUNCTION |
| extensions.is_contained_2d | bool | geometry, box2df | FUNCTION |
| extensions.overlaps_2d | bool | geometry, box2df | FUNCTION |
| extensions.overlaps_nd | bool | gidx, geometry | FUNCTION |
| extensions.overlaps_nd | bool | gidx, gidx | FUNCTION |
| extensions.overlaps_nd | bool | geometry, gidx | FUNCTION |
| extensions.geom2d_brin_inclusion_add_value | bool | internal, internal, internal, internal | FUNCTION |
| extensions.geom3d_brin_inclusion_add_value | bool | internal, internal, internal, internal | FUNCTION |
| extensions.geom4d_brin_inclusion_add_value | bool | internal, internal, internal, internal | FUNCTION |
| extensions.geometry_spgist_compress_nd | internal | internal | FUNCTION |
| extensions.geography_spgist_config_nd | void | internal, internal | FUNCTION |
| extensions.geography_spgist_choose_nd | void | internal, internal | FUNCTION |
| extensions.geography_spgist_picksplit_nd | void | internal, internal | FUNCTION |
| extensions.geography_spgist_inner_consistent_nd | void | internal, internal | FUNCTION |
| extensions._st_concavehull | geometry | param_inputgeom geometry | FUNCTION |
| extensions.st_concavehull | geometry | param_geom geometry, param_pctconvex double precision, param_allow_holes boolean DEFAULT false | FUNCTION |
| extensions._st_asx3d | text | integer, geometry, integer, integer, text | FUNCTION |
| extensions.st_asx3d | text | geom geometry, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0 | FUNCTION |
| extensions.st_angle | float8 | line1 geometry, line2 geometry | FUNCTION |
| extensions.st_3dlineinterpolatepoint | geometry | geometry, double precision | FUNCTION |
| extensions.geometry_spgist_config_2d | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_choose_2d | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_picksplit_2d | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_inner_consistent_2d | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_leaf_consistent_2d | bool | internal, internal | FUNCTION |
| extensions.geometry_spgist_compress_2d | internal | internal | FUNCTION |
| extensions.geometry_overlaps_3d | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_contains_3d | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_contained_3d | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_same_3d | bool | geom1 geometry, geom2 geometry | FUNCTION |
| extensions.geometry_spgist_config_3d | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_choose_3d | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_picksplit_3d | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_inner_consistent_3d | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_leaf_consistent_3d | bool | internal, internal | FUNCTION |
| extensions.geometry_spgist_compress_3d | internal | internal | FUNCTION |
| extensions.geometry_spgist_config_nd | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_choose_nd | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_picksplit_nd | void | internal, internal | FUNCTION |
| extensions.geometry_spgist_inner_consistent_nd | void | internal, internal | FUNCTION |
| extensions.geography_spgist_leaf_consistent_nd | bool | internal, internal | FUNCTION |
| extensions.geography_spgist_compress_nd | internal | internal | FUNCTION |
| public.is_without_whitespace | bool | str text | FUNCTION |
| public.is_singleline | bool | str text | FUNCTION |
| public.is_strlen | bool | str text, min integer, max integer | FUNCTION |
| profiles.create_associated_profile | trigger |  | FUNCTION |
| profiles.delete_associated_profile | trigger |  | FUNCTION |
| public.delete_account | void |  | FUNCTION |

## Relations

![er](schema.png)

---

> Generated by [tbls](https://github.com/k1LoW/tbls)
