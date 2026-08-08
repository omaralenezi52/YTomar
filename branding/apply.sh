#!/usr/bin/env bash
# ============================================================
#  apply.sh — يطبّق وسم YTomar وحقوق Omar Alenezi (@o5252i)
#  على مصدر uYouPlus المستنسخ. يُشغَّل من داخل مجلد upstream/.
#  BSD sed (macOS runner): sed -i '' -e ...
# ============================================================
set -e
echo "==> تطبيق وسم YTomar (@o5252i)"

CREDIT="Omar Alenezi (Telegram: @o5252i)"

# ---- 1) ميتاداتا الحزمة (تظهر في مدير الحزم) ----
if [ -f control ]; then
  sed -i '' -e "s/^Name: .*/Name: YTomar/" control || true
  sed -i '' -e "s/^Maintainer: .*/Maintainer: ${CREDIT}/" control || true
  sed -i '' -e "s/^Author: .*/Author: ${CREDIT}/" control || true
  sed -i '' -e "s#^Description: .*#Description: YTomar — unified YouTube build (all uYouPlus features). Credit: ${CREDIT}#" control || true
  echo "-- control بعد الوسم --"; cat control | head -6
fi

# ---- 2) عنوان قسم الإعدادات داخل التطبيق (مرئي للمستخدم) ----
# نستبدل عنوان قسم "uYouPlus" الظاهر بـ "YTomar · @o5252i"
FILES=$(grep -rIl '@"uYouPlus"' --include=*.x --include=*.xm --include=*.m --include=*.mm . 2>/dev/null || true)
if [ -n "$FILES" ]; then
  for f in $FILES; do
    sed -i '' -e 's/@"uYouPlus"/@"YTomar · @o5252i"/g' "$f" || true
    echo "  ✎ وسم عنوان الإعدادات في: $f"
  done
else
  echo "  (لم يُعثر على @\"uYouPlus\" — سيبقى العنوان الأصلي، الحقوق موجودة في الحزمة)"
fi

# ---- 3) ملفات الترجمة (Localizable) إن وُجدت ----
LOC=$(grep -rIl 'uYouPlus' --include=*.strings . 2>/dev/null || true)
for f in $LOC; do
  sed -i '' -e 's/uYouPlus/YTomar (@o5252i)/g' "$f" || true
done

# ---- 4) ترقيع توافق: %orig كوسيط دالة يكسر logos ----
# YouPiP/LegacyPiPCompat.x: نخزّن %orig في متغيّر بدل تمريره مباشرة
PIPF="Tweaks/YouPiP/LegacyPiPCompat.x"
if [ -f "$PIPF" ]; then
  perl -0pi -e 's/return initPlayerPiPControllerIfNeeded\(%orig, delegate, nil\);/id _yo = %orig; return initPlayerPiPControllerIfNeeded(_yo, delegate, nil);/g' "$PIPF"
  perl -0pi -e 's/return initPlayerPiPControllerIfNeeded\(%orig, delegate, parentResponder\);/id _yo = %orig; return initPlayerPiPControllerIfNeeded(_yo, delegate, parentResponder);/g' "$PIPF"
  echo "  ✎ رقّعت LegacyPiPCompat.x (%orig → متغيّر)"
fi

# uYouPlus.xm: %orig(وسيط صريح) يرفضه logos الحديث → نعدّل arg1 ثم %orig عادي
UYXM="Sources/uYouPlus.xm"
if [ -f "$UYXM" ]; then
  perl -0pi -e 's/return IS_ENABLED\(kHideCC\) \? %orig\(NO\) : %orig;/arg1 = IS_ENABLED(kHideCC) ? NO : arg1; %orig;/g' "$UYXM"
  perl -0pi -e 's/\Q%orig(YES);\E/arg1 = YES; %orig;/g' "$UYXM"
  perl -0pi -e 's/\{ %orig\(0\); \}/{ arg1 = 0; %orig; }/g' "$UYXM"
  echo "  ✎ رقّعت uYouPlus.xm (4 حالات %orig بوسيط صريح)"
  echo "  تحقق: باقي %orig( بوسيط؟"; grep -nE '%orig\([^)]' "$UYXM" || echo "  لا شيء ✅"
fi

echo "==> اكتمل الوسم ✅"
