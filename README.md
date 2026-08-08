# YTomar — واجهة يوتيوب موحّدة في dylib واحد
**المطوّر / الحقوق: Omar Alenezi — تيليجرام: [@o5252i](https://t.me/o5252i)** · الإصدار 1.0.0

يجمع هذا المشروع مميزات حزمة **uYouPlus** (كانت موزّعة على 18 ملف dylib) داخل **ملف واحد** منظّم وعصري، يُبنى تلقائياً إلى **`YTomar.dylib`** عبر GitHub Actions.

---

## 👷 المهندس — فهم الـ18 ملف بعناية والفائدة من كل واحد
| # | الملف الأصلي | الفكرة / الأهمية | حالته عندنا |
|---|---|---|---|
| 1 | **uYouPlus** | التويك الجامع + لوحة الإعدادات | `07_Settings.x` |
| 2 | **uYou** | الأساس (AFNetworking للتحميل + AVPictureInPictureController) | مبدأه مدمج في PiP |
| 3 | **NoYTPremium** | كبح ترويج Premium/interstitials/استبيانات | `01_NoPremium.x` |
| 4 | **YouPiP** | تشغيل مصغّر (MLPIPController) | `02_PiP.x` |
| 5 | **YouMute** | تذكّر كتم الصوت بين الفيديوهات | مدمج بطبقة الأزرار |
| 6 | **YouQuality** | جودة افتراضية ثابتة | `04_Quality.x` |
| 7 | **YTUHD** | فتح 4K/UHD (YTHotConfig) | `03_UHD.x` |
| 8 | **YoutubeSpeed** | سرعات تشغيل موسّعة (YTVarispeed) | `05_Speed.x` |
| 9 | **YTClassicVideoQuality** | قائمة الجودة الكلاسيكية | `04_Quality.x` |
| 10 | **YTVideoOverlay** | إطار أزرار فوق المشغّل (تعتمده تويكات أخرى) | أساس طبقة الإعداد |
| 11 | **DontEatMyContent** | منع قص المحتوى خلف الحواف/النوتش | `06_Interface.x` |
| 12 | **IAmYouTube** | انتحال هوية يوتيوب الرسمية (للبثّ Cast) | `06_Interface.x` |
| 13 | **YTABConfig** | تحكم بتجارب A/B (YTGlobal/Cold/HotConfig) | جاهز كوحدة قابلة للإضافة |
| 14 | **YouTubeDislikesReturn** | رجوع عدّاد الديسلايك (خدمة RYD — شبكي) | وحدة شبكية، انظر أدناه |
| 15 | **iSponsorBlock** | تخطّي المقاطع الإعلانية (**Swift** + SponsorBlock API — شبكي) | وحدة شبكية، انظر أدناه |
| 16 | **libcolorpicker** | منتقي ألوان الإعدادات (يعتمد Alderis) | مكتبة مساعدة للـUI |
| 17 | **libFLEX** | أداة تصحيح داخل التطبيق (للمطوّر فقط) | غير مطلوبة للمستخدم |
| 18 | **libswift_Concurrency** | رنتايم Swift (async/await) اللازم لِـ iSponsorBlock | تُحزَّم آلياً مع Swift |

> كل الأسماء أعلاه **مستخرجة فعلياً** من رموز الملفات (تحليل ثنائي)، مو تخمين.

## ✅ المحقق — قائمة التحقق
- [x] إلغاء ترويج Premium — [x] PiP — [x] 4K/UHD — [x] جودة افتراضية
- [x] قائمة جودة كلاسيكية — [x] سرعات موسّعة — [x] منع قص المحتوى
- [x] هوية يوتيوب الرسمية — [x] لوحة إعدادات + توقيع المطوّر
- [ ] SponsorBlock / RYD → **وحدات شبكية** (تُضاف كـ submodules، القسم أدناه)

## 🚀 المحسّن — ما الذي عُصرِن
- توحيد 18 ملف في **dylib واحد** = إقلاع أسرع وذاكرة أقل وصيانة أسهل.
- قارئ إعدادات موحّد `YTOmarPref` بدل تكرار المنطق.
- **ARC** + مجموعات `%group` تُفعّل عند الطلب فقط + دعم `arm64/arm64e`.

## 🎨 التصميم
بنية معيارية مرقّمة `00_→07_`، كل ميزة قابلة للإطفاء من `NSUserDefaults` (نطاق `com.omarshouf.ytomar`)، وتوقيعك يظهر في الكونسول وفي الإعدادات.

## 🧠 الفاحص المدقّق — تأكيد التجميع
ابحث في سجل الجهاز بعد التشغيل عن:
```
[YTomar] ✅ loaded — unified tweak by Omar Alenezi (Telegram: @o5252i) v1.0.0
```

---

## 🔧 البناء التلقائي (GitHub Actions — لا تحتاج ماك)
عند رفع المشروع للمستودع، يشتغل الـ workflow في `.github/workflows/build.yml` تلقائياً على runner ماك، ويُنتج:
- **`YTomar.dylib`** (الملف الخام) كـ artifact
- **`com.omarshouf.ytomar_1.0.0_iphoneos-arm.deb`** (حزمة للتثبيت)

نزّلهم من تبويب **Actions → آخر build → Artifacts**، أو من **Releases** لو أنشأت تاج.

### بناء يدوي (لو عندك ماك/لينكس + Theos)
```bash
export THEOS=~/theos
make clean && make            # ⇒ .theos/obj/YTomar.dylib
make package FINALPACKAGE=1   # ⇒ packages/*.deb
```

## ⚠️ ملاحظة بصراحة
**SponsorBlock (iSponsorBlock) و YouTubeDislikesReturn** كود شبكي كبير (Swift + خوادم خارجية). الأنظف دمجهما كـ submodules من مصدرهما الأصلي — أضِف مجلديهما تحت `Sources/` والـ Makefile يلتقطهما تلقائياً، ويُحزَّم رنتايم Swift معهما.

## الحقوق
جميع الحقوق للمطوّر **Omar Alenezi — تيليجرام [@o5252i](https://t.me/o5252i)**. المميزات مبنية على مشاريع مفتوحة المصدر؛ يُرجى احترام تراخيصها عند التوزيع.
