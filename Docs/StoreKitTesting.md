# StoreKit Local Testing – SOLARA

## Setup

1. Open `SOLARA.xcodeproj` in Xcode
2. Edit the active scheme: **Product → Scheme → Edit Scheme…**
3. Under **Run → Options → StoreKit Configuration**, select `Products.storekit`
4. Build and run on Simulator or device

## StoreKit Configuration File

`SOLARA/Products.storekit` contains four consumable products:

| Product ID | Price (Test) | Type |
|---|---|---|
| solara.tea | $0.99 | Consumable |
| solara.stone | $2.99 | Consumable |
| solara.mercurykit | $4.99 | Consumable |
| solara.patron | $9.99 | Consumable |

## Test Cases

### 1. Successful Purchase
- Open Shop → Tap "Support" on any product
- Confirm in the StoreKit test payment sheet
- **Expected:** Thank-you popup appears, transaction finishes

### 2. Cancelled Purchase
- Open Shop → Tap "Support" → Cancel the payment sheet
- **Expected:** Cancelled message or silent dismissal

### 3. Failed Purchase
- In Xcode: **Debug → StoreKit → Enable "Fail Transactions"**
- Attempt a purchase
- **Expected:** Error popup with retry suggestion

### 4. Pending Purchase (Ask to Buy)
- In Xcode: **Debug → StoreKit → Enable "Ask to Buy"**
- Attempt a purchase → Approve/deny in Transaction Manager
- **Expected:** Pending message while waiting for approval

### 5. No Network / Store Unavailable
- Disconnect network or enable StoreKit error for "Load Products"
- Open Shop
- **Expected:** Error state with retry button shown

### 6. Localization
- Change device/simulator language to EN/ES/PT-BR
- Open Shop
- **Expected:** All shop texts appear in the selected language; prices use locale-appropriate formatting

## Sandbox / TestFlight Testing

For Sandbox testing (real App Store Connect products):
1. Remove the StoreKit Configuration from the scheme
2. Sign in with a Sandbox Apple ID on device (Settings → App Store → Sandbox Account)
3. Products must exist in App Store Connect with status "Ready to Submit"
4. Purchases will use Sandbox environment automatically
