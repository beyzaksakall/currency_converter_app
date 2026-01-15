# DÖVİZMATİK – Flutter Döviz Dönüştürücü Uygulaması
[![YouTube Video](https://img.youtube.com/vi//wcIHj0DUqAA?si=mnX5cKg9kLr-ygVz/0.jpg)](https://youtu.be/wcIHj0DUqAA?si=mnX5cKg9kLr-ygVz)

**DÖVİZMATİK**, Flutter kullanılarak geliştirilmiş, kullanıcıların farklı para birimleri arasında hızlı ve pratik şekilde dönüşüm yapabilmesini sağlayan bir mobil uygulamadır.  
Uygulama; döviz dönüştürme, grafiklerle kur takibi ve işlem geçmişi gibi temel özellikleri tek bir arayüzde sunar.

<img width="374" height="694" alt="Ekran görüntüsü 2026-01-14 200643" src="https://github.com/user-attachments/assets/8839652b-49a9-4645-a43a-10a56d72ad85" />

<img width="374" height="694" alt="Ekran görüntüsü 2026-01-14 200625" src="https://github.com/user-attachments/assets/f984cb22-43df-4aad-9b26-602e7e908233" />

<img width="374" height="694" alt="Ekran görüntüsü 2026-01-14 200716" src="https://github.com/user-attachments/assets/2841d813-94b3-4c0c-8dca-90fd705fdfa8" />

<img width="374" height="694" alt="Ekran görüntüsü 2026-01-14 200705" src="https://github.com/user-attachments/assets/4475340f-da84-4f77-855a-067a36de0205" />

---

##  Özellikler

### 🔄 Döviz Dönüştürme
- Kullanıcı istediği para birimlerini seçerek dönüşüm yapabilir.
- Girilen miktar anında hesaplanır ve sonuç ekranda gösterilir.
- Kullanılan kurlar uygulama içinde sabit olarak tanımlanmıştır (temsili).

### 📊 Grafik Ekranı
- 1 USD’nin farklı para birimleri karşısındaki değişimini gösterir.
- TRY, EUR, GBP ve JPY için ayrı ayrı çizgi grafikler bulunmaktadır.
- Grafikler görsel amaçlıdır ve son değerler tanımlı kur değerlerine karşılık gelir.

###  Geçmiş İşlemler
- Yapılan tüm dönüşümler yerel veritabanında saklanır.
- Tarih ve saat bilgisiyle birlikte listelenir.
- Kullanıcı geçmişi tek tuşla tamamen temizleyebilir.

###  Kullanıcı Arayüzü
- Modern ve sade bir tasarım anlayışı kullanılmıştır.
- Mürdüm & gri renk teması tercih edilmiştir.
- Bottom Navigation Bar ile sayfalar arası geçiş sağlanır.

---

## 🛠️ Kullanılan Teknolojiler
- **Flutter (Dart)**
- **Sqflite** – Yerel veritabanı işlemleri
- **fl_chart** – Grafik çizimleri
- **Material Design** – Arayüz bileşenleri
- **Git & GitHub** – Versiyon kontrolü

---

##  Uygulama Ekranları
- Döviz Dönüştürme Ekranı
- Grafikler Ekranı
- Geçmiş İşlemler Ekranı

---

## 📁 Proje Klasör Yapısı
lib/
├── screens/
│ ├── converter_screen.dart
│ ├── charts_screen.dart
│ ├── history_screen.dart
│ └── main_screen.dart
├── database/
│ └── db_helper.dart
└── main.dart


---

##  Notlar
- Döviz kurları gerçek zamanlı değildir, eğitim ve proje amaçlıdır.
- Grafik verileri temsili olarak oluşturulmuştur.
- Uygulama offline çalışır.

---

## 👩‍💻 Geliştirici
**Beyza Aksakal**  
Flutter & Mobil Uygulama Geliştirme Projesi

---

## Lisans
Bu proje **eğitim amaçlı** geliştirilmiştir.

