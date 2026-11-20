# SisaBijak Mobile

SisaBijak adalah platform e-commerce food rescue berbasis Django yang dirancang untuk mengatasi masalah pemborosan pangan (food waste) dengan menjembatani bisnis kuliner lokal (seperti restoran, kafe, dan toko roti) dengan konsumen. Melalui platform ini, merchant dapat menjual surplus makanan berkualitas yang masih layak konsumsi menjelang jam operasional berakhir dengan potongan harga khusus agar tidak terbuang sia-sia. Inisiatif ini memberikan solusi saling menguntungkan dimana konsumen memperoleh makanan berkualitas dengan harga yang jauh lebih hemat, merchant dapat meminimalisasi kerugian dari stok berlebih, dan lingkungan terlindungi melalui pengurangan emisi karbon akibat limbah makanan.

---

## Tautan Penting
- **Web Deployment**: [SisaBijak Websites (PWS)](https://jefry-acmal-sisabijak.pws.cs.ui.ac.id/)
- **Design Figma**: [SisaBijak Web Design](https://www.figma.com/design/o4NTbzF4o4lhz0H3YpwtPu/TK-PBP?node-id=9-3&t=KAoCwHMU8z00eGQP-1) 
- **Download APK**: *[TBA]*

---

## Anggota Kelompok
1. **Debora Putri Dion Simamora** (2506544126)
2. **Jefry Acmal Dzikhrullah** (2506614795)
3. **Khalisha Nalani Chandra** (2506625041)
4. **Rafael Darius Sagala** (2506584275)
5. **Ghaisan Nabil Iradat** (2506619051)

---

## Roles & Hak Akses
- `Guest` : Pengguna anonim (*AnonymousUser*). Dapat mengakses Landing Page, melihat daftar katalog produk makanan surplus yang tersedia, dan melihat peta lokasi gerai merchant.
- `Consumer` : Akun konsumen (*self-register* via aplikasi). Dapat melakukan pemesanan (checkout), pembayaran via simulasi QRIS/SisaBayarQR, klaim pesanan dengan QR Code klaim di gerai merchant, memberi rating dan ulasan, serta mengakses profil pribadi berisi metrik penghematan dan pencegahan emisi CO₂.
- `Merchant` : Akun mitra bisnis kuliner (*register manual by contact Admin*). Dapat mengelola katalog produk makanan surplus (tambah, edit stok & diskon, hapus produk), memvalidasi penukaran QR Code klaim konsumen, dan mengelola saldo penjualan (*Merchant Wallet*).
- `Admin` : Pengguna *SuperUser* dengan hak akses penuh untuk memoderasi platform, mengelola akun merchant, dan memproses pencairan dana (*disbursement*).

---

## 📱 Daftar Modul & Fitur (Scoping)

### 1. Modul Catalog
* **Penanggung Jawab**: Debora Putri Dion Simamora
* **Deskripsi Fitur**:  
  Modul ini berfungsi sebagai etalase publik tempat pengguna dapat menjelajahi, mencari (*search*), dan memfilter berbagai penawaran makanan surplus dari mitra merchant dengan potongan harga khusus. Pengguna dapat melihat detail produk, lokasi toko, serta jadwal pengambilan (*pickup schedule*) sebelum melakukan pemesanan. Selain itu, modul ini menyediakan sistem ulasan dan penilaian berbasis rating bintang dari konsumen yang telah menyelesaikan transaksi pesanan.
* **Models**:
  * **Model Catalog (Review)**:
    * `user` : Akun Consumer yang memberikan ulasan
    * `order` : Pesanan berstatus `completed` pada sistem OrderSystem yang sedang diulas (1 pesanan = 1 ulasan)
    * `product` : Paket makanan dari Merchant Product yang diulas
    * `rating` : Nilai angka ulasan yang diberikan dalam skala 1–5
    * `comment` : Isi teks ulasan yang ditulis oleh konsumen
    * `created_at` : Waktu sistem saat ulasan pertama kali dibuat
    * `updated_at` : Waktu sistem saat ulasan terakhir kali diubah
* **Endpoints (Django REST Framework)**:
  * `GET /api/v1/catalog/products/` : daftar produk tersedia, bisa pencarian `?q=` dan filter harga `?harga=` (*Auth: Guest, Consumer, Merchant, Admin*)
  * `GET /api/v1/catalog/products/<product_id>/` : detail produk, rata-rata rating, dan info boleh menulis ulasan (*Auth: Guest, Consumer, Merchant, Admin*)
  * `GET /api/v1/catalog/products/<product_id>/reviews/` : daftar ulasan suatu produk (*Auth: Guest, Consumer, Merchant, Admin*)
  * `POST /api/v1/catalog/products/<product_id>/reviews/` : menulis ulasan untuk pesanan yang sudah selesai (*Auth: Consumer*)
  * `PATCH/DELETE /api/v1/catalog/reviews/<review_id>/` : mengubah atau menghapus ulasan milik sendiri (*Auth: Consumer*)
* **Alur Integrasi Data**: halaman Katalog di Flutter memanggil endpoint DRF di atas secara asinkron, Django mengambil data `MerchantProduct` dan `Review` dari database lalu mengubahnya jadi JSON lewat serializer, kemudian Flutter mengubah JSON tersebut menjadi model `Product` dan `Review` untuk ditampilkan.

---

### 2. Modul Merchant Product
* **Penanggung Jawab**: Jefry Acmal Dzikhrullah
* **Deskripsi Fitur**:  
  Modul ini memfasilitasi merchant untuk mengelola inventaris makanan surplus yang siap dijual kepada konsumen melalui dasbor khusus. Merchant dapat menambahkan produk baru, mengatur stok harian, menetapkan harga asli dan diskon, serta menentukan jadwal penjemputan (*pickup schedule*). Selain itu, merchant dapat memperbarui rincian produk, mengunggah foto makanan, maupun menonaktifkan produk yang sudah tidak tersedia.
* **Models**:
  * **Model MerchantProduct**:
    * `product_id` : String ID unik yang dimiliki setiap produk
    * `product_name` : Nama produk yang diunggah merchant
    * `product_stock` : Jumlah produk yang diunggah merchant
    * `product_status` : Status produk (`Available` / `Sold Out` / `Inactive`)
    * `real_price` : Harga asli produk yang diunggah merchant
    * `discount_price` : Besaran harga diskon yang diunggah merchant
    * `start_pickup` : Waktu produk bisa di-pickup (waktu rilis)
    * `end_pickup` : Waktu produk sudah tidak bisa di-pickup (waktu stop)
    * `product_photo` : Berkas gambar/foto produk yang diunggah merchant
* **Views / Endpoints (Backend Django REST / JSON)**:
  * `product_view()` / `get_merchant_products_json()` : Mengambil daftar seluruh produk yang dimiliki oleh merchant yang login (*Auth: Merchant*)
  * `product_create()` : Endpoint untuk menambah produk makanan surplus baru (*Auth: Merchant*)
  * `product_update()` : Endpoint untuk mengubah informasi, stok, harga, atau jam pickup produk (*Auth: Merchant*)
  * `product_delete()` : Endpoint untuk menghapus atau menonaktifkan produk merchant (*Auth: Merchant*)

---

### 3. Modul Order System
* **Penanggung Jawab**: Rafael Darius Sagala
* **Deskripsi Fitur**:  
  Modul ini mengatur alur transaksi pemesanan makanan mulai dari proses checkout keranjang oleh konsumen hingga pembuatan kode QR pembayaran (SisaBayarQR / Dummy QRIS). Setelah pembayaran diverifikasi, sistem menerbitkan kode klaim unik dan QR Code klaim yang dapat ditukarkan konsumen langsung di kasir toko. Kasir merchant selanjutnya memvalidasi QR Code tersebut untuk menyelesaikan pesanan sekaligus mencatat pendapatan ke saldo merchant yang dapat dicairkan (*disbursement*).
* **Models**:
  * **Model OrderSystem**:
    * `consumer` : Relasi ke User akun Consumer
    * `product` : Relasi ke Merchant Product yang dipesan
    * `quantity` : Jumlah produk yang dipesan
    * `unit_price` : Harga satuan produk saat dipesan
    * `total_price` : Total tagihan konsumen
    * `payment_status` : Status pembayaran (`pending`, `paid`, `completed`, `expired`)
    * `payment_qr_id` : ID unik yang disematkan ke dalam SisaBayarQR (Dummy QRIS)
    * `claim_qr_code` : Kode unik khusus untuk proses penukaran makanan di lokasi
    * `pickup_deadline` : Batas waktu konsumen untuk mengambil pesanan
    * `created_at` : Waktu pencatatan pesanan
  * **Model MerchantWallet**:
    * `merchant` : ForeignKey(User), merchant pemilik dompet saldo penjualan
    * `balance` : DecimalField, total akumulasi saldo hasil klaim pesanan yang siap dicairkan
    * `updated_at` : DateTimeField, waktu pembaruan saldo terakhir
* **Views / Endpoints (Backend Django REST / JSON)**:
  * `checkout_view()` : Memproses checkout keranjang dan men-generate SisaBayarQR (*Auth: Consumer*)
  * `payment_view()` : Endpoint instruksi pembayaran dan rincian SisaBayarQR (*Auth: Consumer*)
  * `payment_status_view()` : Endpoint API JSON untuk pengecekan status pembayaran pesanan secara berkala / polling (*Auth: Consumer*)
  * `simulator_bayar_view()` : Simulator pelunasan pembayaran untuk menerbitkan QR Code klaim (*Auth: Consumer, Admin*)
  * `order_list_view()` : Endpoint daftar riwayat pesanan milik konsumen (*Auth: Consumer*)
  * `merchant_order_list_view()` : Endpoint daftar pesanan masuk yang harus dipersiapkan dan diselesaikan oleh merchant (*Auth: Merchant*)
  * `validate_claim_view()` : Endpoint validasi kecocokan kode QR klaim konsumen oleh kasir merchant (*Auth: Merchant*)
  * `withdraw_funds_view()` : Endpoint pengajuan pencairan saldo dompet penjualan merchant (*Auth: Merchant, Admin*)

---

### 4. Modul Consumer Profile
* **Penanggung Jawab**: Khalisha Nalani Chandra
* **Deskripsi Fitur**:  
  Modul ini menyediakan dasbor personal bagi konsumen untuk memantau ringkasan aktivitas transaksi yang telah dilakukan. Selain itu, modul ini juga memfasilitasi konsumen untuk mengelola data akun pribadi, memperbarui nomor kontak, dan memperbarui password akun.
* **Models**:
  * **Model ConsumerProfile**:
    * `user` : Relasi ke User akun Consumer
    * `phone_number` : Nomor telepon akun konsumen
    * `total_orders_completed` : Jumlah total pesanan yang sudah berhasil diselesaikan konsumen
    * `total_money_saved` : Total akumulasi uang yang dihemat (selisih harga asli dan diskon)
    * `total_co2_prevented` : Total akumulasi gas emisi karbon yang berhasil dicegah dari makanan sisa
* **Endpoints (Django REST Framework)**:

  - **GET /profile/ :** Mengambil informasi profil konsumen beserta ringkasan statistik aktivitas, meliputi jumlah pesanan selesai, total uang yang dihemat, dan estimasi emisi karbon yang berhasil dicegah (Auth: Consumer)

  - **POST /consumer/edit-profile/ :** Memproses perubahan informasi akun konsumen, termasuk pembaruan nomor telepon dan password (Auth: Consumer)

  - **GET /consumer/orders/ :** Mengambil riwayat transaksi milik konsumen yang sedang login, mencakup pesanan dengan status pending, paid/siap klaim, dan completed (Auth: Consumer)

* **Alur Integrasi Data:** Modul Consumer Profile menghubungkan aplikasi Flutter dengan backend Django REST Framework untuk mengakses dan mengelola informasi konsumen. Saat konsumen membuka halaman dashboard atau riwayat pesanan, Flutter mengirimkan permintaan GET ke endpoint terkait untuk memperoleh data profil dan transaksi. Backend memproses permintaan tersebut dan mengirimkan respons dalam format JSON agar dapat ditampilkan pada antarmuka aplikasi. Sementara itu, ketika konsumen melakukan perubahan informasi akun melalui halaman Edit Profile, Flutter mengirimkan data menggunakan POST Request ke backend. Django kemudian memvalidasi data dan menyimpan perubahan ke database apabila permintaan berhasil.


---

### 5. Modul Merchant Location Integrator
* **Penanggung Jawab**: Ghaisan Nabil Iradat
* **Deskripsi Fitur**:  
  Modul ini menyajikan peta interaktif untuk membantu konsumen menemukan lokasi restoran, kafe, dan toko roti mitra SisaBijak terdekat secara visual. Pengguna dapat mencari merchant berdasarkan nama toko atau kata kunci alamat serta mengecek titik koordinat lokasi secara presisi. Integrasi ini memudahkan konsumen dalam merencanakan rute penjemputan makanan surplus secara langsung ke gerai merchant.
* **Models**:
  * **Model MerchantLocationIntegrator**:
    * `id_merchant` : String ID unik yang dimiliki setiap merchant
    * `name_merchant` : Nama merchant mitra
    * `address` : Alamat fisik merchant
    * `longitude` : Koordinat bujur (longitude)
    * `latitude` : Koordinat lintang (latitude)
* **Views / Endpoints (Backend Django REST / JSON)**:
  * **Endpoints (Django REST Framework)**:
  * `GET /api/v1/merchants/locations/` : daftar seluruh titik koordinat dan alamat merchant mitra untuk di-render pada peta interaktif, mendukung pencarian nama toko atau kata kunci alamat `?q=` (*Auth: Guest, Consumer, Merchant, Admin*)
  * `GET /api/v1/merchants/locations/<id_merchant>/` : detail informasi dan koordinat presisi (`latitude`, `longitude`) satu merchant mitra saat marker peta dipilih (*Auth: Guest, Consumer, Merchant, Admin*)
* **Alur Integrasi Data**: halaman Peta Interaktif di Flutter memanggil endpoint DRF di atas secara asinkron, Django mengambil data `MerchantLocationIntegrator` dari database lalu mengubahnya menjadi format JSON melalui serializer, kemudian Flutter mem-parsing JSON tersebut menjadi objek model `MerchantLocation` untuk ditampilkan sebagai pin lokasi dan rute penjemputan.

---

### 6. Modul Authentication & Authorization
* **Penanggung Jawab**: Jefry Acmal Dzikhrullah
* **Deskripsi Fitur**:  
  Modul ini menangani sistem pendaftaran akun, autentikasi masuk, dan manajemen sesi login pengguna secara aman. Otorisasi diterapkan berbasis peran (*role-based access control*) untuk membedakan hak akses dan fungsi antara Guest, Consumer, Merchant, dan Admin. Setiap pengguna diarahkan secara otomatis ke alur kerja dan antarmuka yang sesuai dengan hak akses perannya di dalam platform.
* **Models**:
  * **Model UserProfile**:
    * `user` : `OneToOneField(User)`, relasi satu-ke-satu ke model bawaan Django `User`
    * `role` : `CharField`, peran pengguna (`consumer` atau `merchant`)
  * **Base Roles**:
    * `Guest` : AnonymousUser
    * `Consumer` : Akun consumer, self register via form
    * `Merchant` : Akun merchant, register manual by contact Admin
    * `Admin` : SuperUser
* **Views / Endpoints (Backend Django REST / JSON)**:
  * `register()` : Endpoint registrasi akun baru untuk pengguna bertipe Consumer (*Auth: Guest*)
  * `login_user()` : Endpoint autentikasi masuk ke sistem dan inisiasi sesi cookie/token (*Auth: Guest, Consumer, Merchant, Admin*)
  * `logout_user()` : Endpoint untuk mengakhiri sesi login pengguna (*Auth: Consumer, Merchant, Admin*)
  * `profile()` / `account_profile_view()` : Endpoint informasi role dan profil akun login (*Auth: Consumer, Merchant, Admin*)

---

### 7. Modul Landing Page & Base Platform
* **Penanggung Jawab**: Ghaisan Nabil Iradat
* **Deskripsi Fitur**:    
  Modul ini berfungsi sebagai gerbang utama platform SisaBijak. Halaman ini menyajikan penawaran makanan surplus harian (*daily deals*) dengan diskon terbesar serta cuplikan peta gerai mitra terdekat. Selain itu, modul ini menyediakan kerangka tata letak (*base layout*) dan navigasi (seperti *Bottom Navigation* / *Drawer*) sesuai dengan peran (*role*) pengguna.
* **Models**:
  * Mengintegrasikan data dari:
    * `MerchantProduct` : Mengambil produk berstatus *Available* dengan potongan harga tertinggi untuk ditampilkan pada section *daily deals*.
    * `MerchantLocationIntegrator` : Mengambil data koordinat dan alamat toko mitra untuk ditampilkan pada peta interaktif.
* **Views / Endpoints (Backend Django REST / JSON)**:
  * `show_main()` / `get_landing_data_json()` : Endpoint untuk menyajikan data halaman utama, deals surplus harian, ringkasan statistik dampak lingkungan platform, dan informasi merchant terdekat (*Auth: Guest, Consumer, Merchant, Admin*)

---

## 🛠️ Pembagian Job Desk
- `Project Manager`: Jefry Acmal Dzikhrullah
- `Modul Catalog`: Debora Putri Dion Simamora
- `Seeding data merchant & product`: Debora Putri Dion Simamora
- `Modul Order System`: Rafael Darius Sagala
- `Dummy Payment Gateway`: Rafael Darius Sagala
- `Modul Merchant Product`: Jefry Acmal Dzikhrullah
- `Authentication & Authorization`: Jefry Acmal Dzikhrullah
- `Modul Merchant Location Integrator`: Ghaisan Nabil Iradat
- `Landing Page & Base Platform`: Ghaisan Nabil Iradat
- `Modul Consumer Profile`: Khalisha Nalani Chandra
- `Web Design Coordinator`: Khalisha Nalani Chandra

---