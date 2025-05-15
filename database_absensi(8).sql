-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 01 Bulan Mei 2025 pada 04.19
-- Versi server: 8.0.30
-- Versi PHP: 8.2.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database_absensi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `academic_years`
--

CREATE TABLE `academic_years` (
  `id` int NOT NULL,
  `year_name` varchar(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `academic_years`
--

INSERT INTO `academic_years` (`id`, `year_name`, `start_date`, `end_date`, `is_active`, `created_at`, `updated_at`) VALUES
(9, '2024/2025', '2024-07-08', '2025-06-26', 1, '2025-03-22 13:31:57', '2025-03-29 10:49:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `attendance_status`
--

CREATE TABLE `attendance_status` (
  `status_id` int NOT NULL,
  `status_name` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `attendance_status`
--

INSERT INTO `attendance_status` (`status_id`, `status_name`, `created_at`, `updated_at`) VALUES
(1, 'Hadir', '2025-03-22 21:10:14', '2025-03-22 21:10:14'),
(2, 'Sakit', '2025-03-22 21:10:14', '2025-03-22 21:10:14'),
(3, 'Izin', '2025-03-22 21:10:14', '2025-03-22 21:10:14'),
(4, 'Alpha', '2025-03-22 21:10:14', '2025-03-22 21:10:14'),
(5, 'Terlambat', '2025-03-22 21:10:14', '2025-03-22 21:10:14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `books`
--

CREATE TABLE `books` (
  `id` int NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  `publisher` varchar(100) DEFAULT NULL,
  `year_published` year DEFAULT NULL,
  `stock` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `books`
--

INSERT INTO `books` (`id`, `code`, `title`, `author`, `publisher`, `year_published`, `stock`, `created_at`, `updated_at`) VALUES
(6, 'MAT-2022-A1', 'Matematika Dasar', 'Dr. Siti Aminah', 'Penerbit Cerdas', '2022', 10, '2025-04-06 17:49:11', '2025-04-06 17:49:11'),
(7, 'IND-2021-03', 'Bahasa Indonesia', 'Budi Santoso', 'Gramedia', '2021', 15, '2025-04-06 17:49:11', '2025-04-06 17:49:11'),
(8, 'FIS-2020-X', 'Fisika Kelas X', 'Anton Wijaya', 'Penerbit Ilmu', '2020', 7, '2025-04-06 17:49:11', '2025-04-06 17:49:11'),
(9, 'SEJ-2019-02', 'Sejarah Indonesia', 'Rina Wahyuni', 'Erlangga', '2019', 5, '2025-04-06 17:49:11', '2025-04-06 17:49:11'),
(10, 'BIO-2023-B3', 'Biologi SMA', 'Dr. Ahmad Hidayat', 'Bumi Ilmu', '2023', 20, '2025-04-06 17:49:11', '2025-04-06 17:49:11'),
(11, 'KIM-2021-05', 'Kimia Kelas XII', 'Dr. Rina Hartati', 'Kimia Press', '2021', 8, '2025-04-06 17:49:11', '2025-04-06 17:49:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `book_loans`
--

CREATE TABLE `book_loans` (
  `id` int NOT NULL,
  `id_student` varchar(20) DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `loan_date` date NOT NULL,
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT 'On Loan',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `academic_year_id` int NOT NULL,
  `semester_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `classes`
--

CREATE TABLE `classes` (
  `class_id` int NOT NULL,
  `class_name` varchar(50) NOT NULL,
  `id_employee` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `academic_year_id` int NOT NULL,
  `semester_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `classes`
--

INSERT INTO `classes` (`class_id`, `class_name`, `id_employee`, `created_at`, `updated_at`, `academic_year_id`, `semester_id`) VALUES
(1, '10 A', '003', '2025-03-27 01:48:51', '2025-03-29 18:38:48', 9, 1),
(2, '10 B', '003', '2025-03-27 01:48:51', '2025-03-29 18:38:53', 9, 1),
(3, '10 C', '003', '2025-03-27 01:49:34', '2025-03-29 18:38:59', 9, 2),
(4, '11 A', '003', '2025-03-27 01:49:34', '2025-03-29 18:39:05', 9, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `employees`
--

CREATE TABLE `employees` (
  `id_employee` varchar(20) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `birth_place` varchar(100) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` enum('L','P') NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `position_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `employees`
--

INSERT INTO `employees` (`id_employee`, `fullname`, `birth_place`, `birth_date`, `gender`, `phone_number`, `email`, `role_id`, `password`, `photo`, `qr_code`, `created_at`, `updated_at`, `position_id`) VALUES
('001', 'Ahmad Syaiful', 'Yogyakarta', '1990-05-15', 'L', '085612345678', 'AhmadSyaiful@gmail.com\r\n', 2, '$2y$12$O7J5r7xEzQz0syZAFO52oOiiAgKOAesRcGaMiq2K3c.Z5O9ADRzZO', 'ahmad.jpg', 'QR001', '2025-03-16 18:39:59', '2025-04-16 16:02:21', 1),
('003', 'Citra Dewi', 'Jakarta', '2002-06-04', 'P', '081234567890', 'citradewi@gmail.com', NULL, 'Piket123', 'citra.jpg', 'QR003', '2025-03-16 18:39:59', '2025-04-16 10:38:54', 7),
('004', 'Dian Permata', 'Surabaya', '2001-03-12', 'P', '081298765432', NULL, 5, 'Perpus123', 'dian.jpg', 'QR004', '2025-03-16 18:39:59', '2025-03-18 04:54:57', NULL),
('005', 'Eka Saputra', 'Malang', '1988-11-10', 'L', '089675432177', NULL, 3, 'TataUsaha456', 'eka.jpg', 'QR005', '2025-03-16 18:39:59', '2025-03-18 05:11:44', NULL),
('006', 'Fajar Nugroho', 'Semarang', '1995-08-22', 'L', '081234568231', NULL, 4, 'Piket456', 'fajar.jpg', 'QR006', '2025-03-16 18:39:59', '2025-03-18 04:58:13', NULL),
('007', 'Gita Purnama', 'Bandung', '2001-03-12', 'P', '087712345678', NULL, 5, 'Perpus456', 'gita.jpg', 'QR007', '2025-03-16 18:39:59', '2025-03-18 04:55:34', NULL),
('191013002', 'Budi Santoso', 'Bandung', '1992-07-30', 'L', '082134567890', NULL, 3, 'TataUsaha123', 'budi.jpg', 'QR002', '2025-03-16 18:39:59', '2025-03-18 05:06:58', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `employee_attendances`
--

CREATE TABLE `employee_attendances` (
  `id` int NOT NULL,
  `id_employee` varchar(20) DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `attendance_date` date NOT NULL,
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `latitude_in` decimal(10,8) DEFAULT NULL,
  `longitude_in` decimal(11,8) DEFAULT NULL,
  `latitude_out` decimal(10,8) DEFAULT NULL,
  `longitude_out` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `academic_year_id` int NOT NULL,
  `semester_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `employee_subjects`
--

CREATE TABLE `employee_subjects` (
  `id` int NOT NULL,
  `id_employee` varchar(20) DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `holidays`
--

CREATE TABLE `holidays` (
  `id` int NOT NULL,
  `holiday_date` date NOT NULL,
  `description` text,
  `academic_year_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `holidays`
--

INSERT INTO `holidays` (`id`, `holiday_date`, `description`, `academic_year_id`, `created_at`, `updated_at`) VALUES
(15, '2024-08-17', 'Hari Kemerdekaan Indonesia', 9, '2025-03-22 20:58:46', '2025-03-22 20:59:10'),
(16, '2024-12-25', 'Hari Natal', NULL, '2025-03-22 20:58:46', '2025-03-22 20:58:46'),
(17, '2025-01-01', 'Tahun Baru Masehi', NULL, '2025-03-22 20:58:46', '2025-03-22 20:58:46'),
(18, '2025-03-22', 'Hari Raya Nyepi', NULL, '2025-03-22 20:58:46', '2025-03-22 20:58:46');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `payments`
--

CREATE TABLE `payments` (
  `id` int NOT NULL,
  `id_student` varchar(50) NOT NULL,
  `academic_year_id` int NOT NULL,
  `semester_id` int DEFAULT NULL,
  `id_spp` varchar(30) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '500000.00',
  `status` enum('belum','sebagian','lunas') NOT NULL DEFAULT 'belum',
  `last_update` date DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `payments`
--

INSERT INTO `payments` (`id`, `id_student`, `academic_year_id`, `semester_id`, `id_spp`, `amount`, `status`, `last_update`, `notes`) VALUES
(3, 'STU004', 9, 1, '6805cc52a9c51', 800000.00, 'lunas', '2025-04-21', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `payment_history`
--

CREATE TABLE `payment_history` (
  `id` int NOT NULL,
  `payment_id` int NOT NULL,
  `updated_status` enum('belum','sebagian','lunas') NOT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(100) DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `positions`
--

CREATE TABLE `positions` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `positions`
--

INSERT INTO `positions` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Kepala Sekolah', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(2, 'Wakil Kepala Sekolah', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(3, 'Kepala Tata Usaha', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(4, 'Kepala Perpustakaan', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(5, 'Staff Administrasi', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(6, 'Pegawai Piket', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(7, 'Guru Mata Pelajaran', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(8, 'Guru BK (Bimbingan Konseling)', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(9, 'Tenaga Kebersihan', '2025-04-16 16:01:53', '2025-04-16 16:01:53'),
(10, 'Security', '2025-04-16 16:01:53', '2025-04-16 16:01:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `rapor`
--

CREATE TABLE `rapor` (
  `id` int NOT NULL,
  `id_student` varchar(50) NOT NULL,
  `class_id` int NOT NULL,
  `academic_year_id` int NOT NULL,
  `semester_id` int NOT NULL,
  `report_date` date NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `role_name` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `created_at`, `updated_at`) VALUES
(1, 'Wali Kelas', '2025-02-19 07:55:30', '2025-04-16 15:58:36'),
(2, 'Super Admin', '2025-02-19 09:43:15', '2025-04-16 15:50:53'),
(3, 'Admin Tata Usaha', '2025-02-19 09:43:15', '2025-04-16 15:50:53'),
(4, 'Admin Pegawai Piket', '2025-02-19 09:43:15', '2025-04-16 15:50:53'),
(5, 'Admin Perpustakaan', '2025-02-19 09:43:15', '2025-04-16 15:50:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `semesters`
--

CREATE TABLE `semesters` (
  `id` int NOT NULL,
  `academic_year_id` int NOT NULL,
  `semester_name` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `semesters`
--

INSERT INTO `semesters` (`id`, `academic_year_id`, `semester_name`, `start_date`, `end_date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 9, 'Ganjil', '2024-07-08', '2024-12-20', 0, '2025-03-25 17:10:01', '2025-04-21 00:37:45'),
(2, 9, 'Genap', '2025-01-06', '2025-06-26', 0, '2025-03-25 17:10:01', '2025-03-29 11:02:36');

-- --------------------------------------------------------

--
-- Struktur dari tabel `spp`
--

CREATE TABLE `spp` (
  `id` varchar(30) NOT NULL,
  `academic_year_id` int NOT NULL,
  `semester_id` int DEFAULT NULL,
  `class_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '500000.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `spp`
--

INSERT INTO `spp` (`id`, `academic_year_id`, `semester_id`, `class_id`, `amount`, `created_at`, `updated_at`) VALUES
('67effbbe7ef83', 9, 1, 1, 800000.00, '2025-04-04 15:33:18', '2025-04-21 04:42:06');

-- --------------------------------------------------------

--
-- Struktur dari tabel `students`
--

CREATE TABLE `students` (
  `id_student` varchar(20) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `class_id` int DEFAULT NULL,
  `parent_phonecell` varchar(50) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `birth_place` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` enum('L','P') NOT NULL,
  `academic_year_id` int NOT NULL,
  `semester_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `students`
--

INSERT INTO `students` (`id_student`, `fullname`, `class_id`, `parent_phonecell`, `photo`, `password`, `created_at`, `updated_at`, `birth_place`, `birth_date`, `gender`, `academic_year_id`, `semester_id`) VALUES
('STU001', 'Alice Johnson', 1, '1234567890', NULL, 'password123', '2025-03-25 20:18:11', '2025-03-27 01:53:31', 'New York', '2008-05-15', 'P', 9, 1),
('STU002', 'Bob Williams', 3, '2345678901', NULL, 'password234', '2025-03-25 20:18:11', '2025-03-27 02:07:59', 'Los Angeles', '2008-07-22', 'L', 9, 1),
('STU003', 'Charlie Brown', 4, '3456789012', NULL, 'password345', '2025-03-25 20:18:11', '2025-03-27 02:08:09', 'Chicago', '2008-03-10', 'L', 9, 2),
('STU004', 'Diana Garcia', 2, '4567890123', NULL, 'password456', '2025-03-25 20:18:11', '2025-03-26 22:43:19', 'Houston', '2008-11-30', 'P', 9, 1),
('STU005', 'Ethan Martinez', 4, '5678901234', NULL, 'password567', '2025-03-25 20:18:11', '2025-04-21 07:32:02', 'Phoenix', '2007-09-05', 'L', 9, 2),
('STU006', 'PUTRI ADELLIA', 4, '08218213798', 'photos/O4XS0tKIZjyfIAPyFt3s95CfHxGxxXTzwGOybZm8.png', '$2y$12$FxH0Owga8mRABv2JbrvoA.DDdjEfV3FULUpCUVQi83PA.xDT.n1qO', '2025-03-26 20:30:08', '2025-03-26 22:44:21', 'MEDAN', '2003-04-10', 'P', 9, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_attendances`
--

CREATE TABLE `student_attendances` (
  `id` int NOT NULL,
  `id_student` varchar(20) DEFAULT NULL,
  `class_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `attendance_date` date NOT NULL,
  `attendance_time` time NOT NULL,
  `check_in_time` time DEFAULT NULL,
  `check_out_time` time DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `academic_year_id` int NOT NULL,
  `semester_id` int NOT NULL,
  `document` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `academic_year_id` int NOT NULL,
  `semester_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `academic_years`
--
ALTER TABLE `academic_years`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `attendance_status`
--
ALTER TABLE `attendance_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indeks untuk tabel `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `book_loans`
--
ALTER TABLE `book_loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_student` (`id_student`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `academic_year_id` (`academic_year_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indeks untuk tabel `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`class_id`),
  ADD KEY `id_employee` (`id_employee`),
  ADD KEY `academic_year_id` (`academic_year_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indeks untuk tabel `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id_employee`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `position_id` (`position_id`);

--
-- Indeks untuk tabel `employee_attendances`
--
ALTER TABLE `employee_attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_employee` (`id_employee`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `academic_year_id` (`academic_year_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indeks untuk tabel `employee_subjects`
--
ALTER TABLE `employee_subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_employee` (`id_employee`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indeks untuk tabel `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `academic_year_id` (`academic_year_id`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `fk_password_resets_email` (`email`);

--
-- Indeks untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_student` (`id_student`),
  ADD KEY `academic_year_id` (`academic_year_id`);

--
-- Indeks untuk tabel `payment_history`
--
ALTER TABLE `payment_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_id` (`payment_id`);

--
-- Indeks untuk tabel `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `rapor`
--
ALTER TABLE `rapor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_rapor` (`id_student`,`academic_year_id`,`semester_id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `academic_year_id` (`academic_year_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `semesters`
--
ALTER TABLE `semesters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_semesters_academic_year` (`academic_year_id`);

--
-- Indeks untuk tabel `spp`
--
ALTER TABLE `spp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `academic_year_id` (`academic_year_id`);

--
-- Indeks untuk tabel `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id_student`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `fk_students_academic_year` (`academic_year_id`),
  ADD KEY `fk_students_semester` (`semester_id`);

--
-- Indeks untuk tabel `student_attendances`
--
ALTER TABLE `student_attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_student` (`id_student`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `academic_year_id` (`academic_year_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indeks untuk tabel `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD KEY `fk_subjects_academic_year` (`academic_year_id`),
  ADD KEY `fk_subjects_semester` (`semester_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `academic_years`
--
ALTER TABLE `academic_years`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `attendance_status`
--
ALTER TABLE `attendance_status`
  MODIFY `status_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `books`
--
ALTER TABLE `books`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `book_loans`
--
ALTER TABLE `book_loans`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `classes`
--
ALTER TABLE `classes`
  MODIFY `class_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `employee_attendances`
--
ALTER TABLE `employee_attendances`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `employee_subjects`
--
ALTER TABLE `employee_subjects`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `payment_history`
--
ALTER TABLE `payment_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `positions`
--
ALTER TABLE `positions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `rapor`
--
ALTER TABLE `rapor`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `semesters`
--
ALTER TABLE `semesters`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `student_attendances`
--
ALTER TABLE `student_attendances`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `book_loans`
--
ALTER TABLE `book_loans`
  ADD CONSTRAINT `book_loans_ibfk_1` FOREIGN KEY (`id_student`) REFERENCES `students` (`id_student`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_loans_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_loans_ibfk_3` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`),
  ADD CONSTRAINT `book_loans_ibfk_4` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`);

--
-- Ketidakleluasaan untuk tabel `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id_employee`) ON DELETE SET NULL,
  ADD CONSTRAINT `classes_ibfk_2` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`),
  ADD CONSTRAINT `classes_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`);

--
-- Ketidakleluasaan untuk tabel `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `employee_attendances`
--
ALTER TABLE `employee_attendances`
  ADD CONSTRAINT `employee_attendances_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id_employee`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_attendances_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `attendance_status` (`status_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_attendances_ibfk_3` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`),
  ADD CONSTRAINT `employee_attendances_ibfk_4` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`);

--
-- Ketidakleluasaan untuk tabel `employee_subjects`
--
ALTER TABLE `employee_subjects`
  ADD CONSTRAINT `employee_subjects_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id_employee`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `holidays`
--
ALTER TABLE `holidays`
  ADD CONSTRAINT `holidays_ibfk_1` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `fk_password_resets_email` FOREIGN KEY (`email`) REFERENCES `employees` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`id_student`) REFERENCES `students` (`id_student`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`);

--
-- Ketidakleluasaan untuk tabel `payment_history`
--
ALTER TABLE `payment_history`
  ADD CONSTRAINT `payment_history_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Ketidakleluasaan untuk tabel `rapor`
--
ALTER TABLE `rapor`
  ADD CONSTRAINT `rapor_ibfk_1` FOREIGN KEY (`id_student`) REFERENCES `students` (`id_student`) ON DELETE CASCADE,
  ADD CONSTRAINT `rapor_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rapor_ibfk_3` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rapor_ibfk_4` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `semesters`
--
ALTER TABLE `semesters`
  ADD CONSTRAINT `fk_semesters_academic_year` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `semesters_ibfk_1` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_academic_year` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_students_semester` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `student_attendances`
--
ALTER TABLE `student_attendances`
  ADD CONSTRAINT `student_attendances_ibfk_1` FOREIGN KEY (`id_student`) REFERENCES `students` (`id_student`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_attendances_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_attendances_ibfk_3` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_attendances_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `attendance_status` (`status_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_attendances_ibfk_5` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`),
  ADD CONSTRAINT `student_attendances_ibfk_6` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`);

--
-- Ketidakleluasaan untuk tabel `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `fk_subjects_academic_year` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_subjects_semester` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
