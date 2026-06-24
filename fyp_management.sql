-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2026 at 07:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fyp_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `committees`
--

CREATE TABLE `committees` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `department` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `committees`
--

INSERT INTO `committees` (`user_id`, `name`, `designation`, `department`) VALUES
(4, 'Prof. Zahid Ali', NULL, 'Software Engineering'),
(10015, 'Faheem Abbasi', NULL, 'Software Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `coordinators`
--

CREATE TABLE `coordinators` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `department` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coordinators`
--

INSERT INTO `coordinators` (`user_id`, `name`, `designation`, `department`) VALUES
(10016, 'Prof. Mumtaz', NULL, 'Software Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `deadlines`
--

CREATE TABLE `deadlines` (
  `id` int(11) NOT NULL,
  `stage` enum('Proposal Submission','Proposal Defence Presentation','FYP Progress Presentation','Final Presentation') NOT NULL,
  `department` varchar(100) NOT NULL DEFAULT 'Software Engineering',
  `deadline_date` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('Active','Inactive') DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deadlines`
--

INSERT INTO `deadlines` (`id`, `stage`, `department`, `deadline_date`, `updated_at`, `status`) VALUES
(3, 'FYP Progress Presentation', 'Software Engineering', '2026-12-15 23:59:00', '2026-06-19 12:16:12', 'Active'),
(22, 'Proposal Defence Presentation', 'Software Engineering', '2026-06-22 20:20:00', '2026-06-22 15:16:42', 'Active'),
(23, 'Final Presentation', 'Information Technology', '2026-06-24 18:40:00', '2026-06-23 12:40:17', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `evaluations`
--

CREATE TABLE `evaluations` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `evaluator_id` int(11) NOT NULL,
  `stage` enum('Proposal Defence Presentation','FYP Progress Presentation','Final Presentation') NOT NULL,
  `marks_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`marks_details`)),
  `total_marks` decimal(5,2) NOT NULL,
  `remarks` text DEFAULT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `show_to_student` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `evaluations`
--

INSERT INTO `evaluations` (`id`, `group_id`, `evaluator_id`, `stage`, `marks_details`, `total_marks`, `remarks`, `scheduled_date`, `created_at`, `show_to_student`) VALUES
(1, 1, 4, 'Proposal Defence Presentation', '{\"problem_solution\":10,\"literature_feasibility\":10,\"presentation_viva\":10}', 30.00, 'Better Idea', NULL, '2026-06-18 04:24:05', 1),
(5, 4, 4, 'FYP Progress Presentation', '{}', 0.00, NULL, '2027-07-23 11:33:00', '2026-06-18 05:05:44', 1),
(50, 1, 10015, 'Proposal Defence Presentation', '{\"problem_solution\":5,\"literature_feasibility\":5,\"presentation_viva\":5}', 15.00, '', NULL, '2026-06-19 12:20:14', 1),
(51, 1, 4, 'FYP Progress Presentation', '{\"understanding\":10,\"technical_knowledge\":9,\"implementation_progress\":5,\"presentation_qa\":10}', 34.00, '', NULL, '2026-06-23 03:42:42', 1),
(52, 1, 4, 'Final Presentation', '{\"project_demo\":23,\"thesis\":25,\"presentation\":20}', 68.00, '', NULL, '2026-06-23 03:43:04', 1),
(53, 4, 4, 'Proposal Defence Presentation', '{\"problem_solution\":10,\"literature_feasibility\":10,\"presentation_viva\":10}', 30.00, '', NULL, '2026-06-23 17:02:24', 1);

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `group_id` int(11) NOT NULL,
  `proposal_marks` decimal(5,2) DEFAULT 0.00,
  `total_marks` decimal(5,2) DEFAULT 0.00,
  `percentage` decimal(5,2) DEFAULT 0.00,
  `grade` varchar(5) DEFAULT 'F',
  `status` enum('Pass','Fail') DEFAULT 'Fail',
  `calculated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `proposal_defense_marks` decimal(5,2) DEFAULT NULL,
  `progress_presentation_marks` decimal(5,2) DEFAULT NULL,
  `final_presentation_marks` decimal(5,2) DEFAULT NULL,
  `supervision_marks` decimal(5,2) DEFAULT NULL,
  `show_supervision_to_student` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`group_id`, `proposal_marks`, `total_marks`, `percentage`, `grade`, `status`, `calculated_at`, `proposal_defense_marks`, `progress_presentation_marks`, `final_presentation_marks`, `supervision_marks`, `show_supervision_to_student`) VALUES
(1, 10.00, 165.00, 83.00, 'A', 'Pass', '2026-06-23 10:30:01', 23.00, 34.00, 68.00, 30.00, 1),
(4, 10.00, 52.00, 26.00, 'F', 'Fail', '2026-06-23 17:02:24', 30.00, NULL, NULL, 12.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `group_code` varchar(50) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `progress_stage` enum('Account Created','Group Created','Proposal Submitted','Proposal Approved','Proposal Defence Presentation Completed','FYP Progress Presentation Completed','Final Presentation Completed','Final Grading Completed') DEFAULT 'Group Created',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group_code`, `created_by`, `progress_stage`, `created_at`) VALUES
(1, '2k23-SWEM-1', 15, 'Final Grading Completed', '2026-06-15 15:54:27'),
(4, '2K24-SWEM-1', 18, 'Proposal Defence Presentation Completed', '2026-06-18 04:18:57');

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `group_members`
--

INSERT INTO `group_members` (`id`, `group_id`, `student_id`, `joined_at`) VALUES
(1, 1, 15, '2026-06-15 15:54:27'),
(5, 4, 18, '2026-06-18 04:18:57'),
(6, 1, 14, '2026-06-18 05:22:17'),
(7, 1, 16, '2026-06-18 05:22:17');

-- --------------------------------------------------------

--
-- Table structure for table `hods`
--

CREATE TABLE `hods` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hods`
--

INSERT INTO `hods` (`user_id`, `name`, `department`) VALUES
(2, 'Arifa Bhutto', 'Software Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `notice_date` date NOT NULL,
  `ref_no` varchar(100) DEFAULT NULL,
  `target_audience` varchar(100) NOT NULL DEFAULT 'students',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`id`, `sender_id`, `subject`, `body`, `notice_date`, `ref_no`, `target_audience`, `created_at`) VALUES
(11, 10016, 'Extension of Final Year Project (FYP) Proposal Submission Date', 'The new submission deadline is [New Date], replacing the previously announced deadline of [Old Date]. This extension has been granted to provide students with additional time to finalize their project ideas, prepare the required documentation, and obtain approval from their supervisors.\r\n\r\nStudents are advised to submit their proposals before the revised deadline, as no further extensions are expected. Late submissions may not be considered.\r\n\r\nFor any queries or assistance regarding the proposal submission process, students may contact the FYP Coordinator.\r\n\r\nWe encourage all students to make use of this additional time effectively and ensure that their proposals meet the required academic standards.', '2026-06-20', NULL, 'students,supervisors,committee,hod', '2026-06-20 07:41:39');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `redirect_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `is_read`, `created_at`, `redirect_url`) VALUES
(1, 11, 'Proposal Submitted', 'Group GRP-2026-F99F has submitted a project proposal selecting you as supervisor.', 1, '2026-06-15 15:54:27', NULL),
(2, 1, 'Proposal Submitted', 'Group GRP-2026-F99F has submitted a project proposal.', 1, '2026-06-15 15:54:27', NULL),
(3, 2, 'Proposal Submitted', 'Group GRP-2026-F99F has submitted a project proposal.', 1, '2026-06-15 15:54:27', NULL),
(4, 14, 'Proposal Reviewed', 'Your project proposal has been Revision Requested by your supervisor.', 1, '2026-06-15 16:38:26', NULL),
(5, 15, 'Proposal Reviewed', 'Your project proposal has been Revision Requested by your supervisor.', 1, '2026-06-15 16:38:26', NULL),
(6, 11, 'Proposal Submitted', 'Group 2k23-SWEM-1 has submitted a project proposal selecting you as supervisor.', 1, '2026-06-16 13:57:10', NULL),
(7, 1, 'Proposal Submitted', 'Group 2k23-SWEM-1 has submitted a project proposal.', 1, '2026-06-16 13:57:10', NULL),
(8, 2, 'Proposal Submitted', 'Group 2k23-SWEM-1 has submitted a project proposal.', 1, '2026-06-16 13:57:10', NULL),
(9, 14, 'Proposal Reviewed', 'Your project proposal has been Rejected by your supervisor.', 1, '2026-06-16 13:58:02', NULL),
(10, 15, 'Proposal Reviewed', 'Your project proposal has been Rejected by your supervisor.', 1, '2026-06-16 13:58:02', NULL),
(11, 11, 'Proposal Submitted', 'Group 2k23-SWEM-1 has submitted a project proposal selecting you as supervisor.', 1, '2026-06-16 13:59:13', NULL),
(12, 1, 'Proposal Submitted', 'Group 2k23-SWEM-1 has submitted a project proposal.', 1, '2026-06-16 13:59:13', NULL),
(13, 2, 'Proposal Submitted', 'Group 2k23-SWEM-1 has submitted a project proposal.', 1, '2026-06-16 13:59:13', NULL),
(14, 14, 'Proposal Reviewed', 'Your project proposal has been Approved by your supervisor.', 1, '2026-06-16 13:59:46', NULL),
(15, 15, 'Proposal Reviewed', 'Your project proposal has been Approved by your supervisor.', 1, '2026-06-16 13:59:46', NULL),
(16, 9, 'Deadline Updated', 'The deadline for FYP-II has been updated to 2027-03-12T23:03.', 0, '2026-06-16 14:11:07', NULL),
(17, 10, 'Deadline Updated', 'The deadline for FYP-II has been updated to 2027-03-12T23:03.', 0, '2026-06-16 14:11:07', NULL),
(18, 5, 'Deadline Updated', 'The deadline for FYP-II has been updated to 2027-03-12T23:03.', 0, '2026-06-16 14:11:07', NULL),
(19, 6, 'Deadline Updated', 'The deadline for FYP-II has been updated to 2027-03-12T23:03.', 0, '2026-06-16 14:11:07', NULL),
(20, 14, 'Deadline Updated', 'The deadline for FYP-II has been updated to 2027-03-12T23:03.', 1, '2026-06-16 14:11:07', NULL),
(21, 7, 'Deadline Updated', 'The deadline for FYP-II has been updated to 2027-03-12T23:03.', 0, '2026-06-16 14:11:07', NULL),
(22, 15, 'Deadline Updated', 'The deadline for FYP-II has been updated to 2027-03-12T23:03.', 1, '2026-06-16 14:11:07', NULL),
(24, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 14:16:02', NULL),
(25, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 14:16:02', NULL),
(26, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 14:16:08', NULL),
(27, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 14:16:08', NULL),
(28, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 14:16:37', NULL),
(29, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 14:16:37', NULL),
(30, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 15:47:16', NULL),
(31, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 15:47:16', NULL),
(32, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 15:47:57', NULL),
(33, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-16 15:47:57', NULL),
(34, 1, 'New Student Registration', 'Student Muhammad Shaheer (2k23/SWE/111) registered and is pending approval.', 1, '2026-06-16 18:47:41', NULL),
(35, 1, 'New Student Registration', 'Student Furqan (2k23/SWE/100) registered and is pending approval.', 1, '2026-06-16 18:49:56', NULL),
(36, 16, 'Account Approved', 'Your registration has been approved! You can now log in.', 0, '2026-06-18 04:04:26', NULL),
(37, 1, 'New Student Registration', 'Student Fariya (2K24/SWE/033) registered and is pending approval.', 1, '2026-06-18 04:17:00', NULL),
(38, 18, 'Account Approved', 'Your registration has been approved! You can now log in.', 1, '2026-06-18 04:17:43', NULL),
(39, 11, 'Proposal Submitted', 'Group 2K24-SWEM-1 has submitted a project proposal selecting you as supervisor.', 1, '2026-06-18 04:18:57', NULL),
(40, 1, 'Proposal Submitted', 'Group 2K24-SWEM-1 has submitted a project proposal.', 1, '2026-06-18 04:18:57', NULL),
(41, 2, 'Proposal Submitted', 'Group 2K24-SWEM-1 has submitted a project proposal.', 1, '2026-06-18 04:18:57', NULL),
(42, 14, 'Marks Awarded', 'Evaluation marks for Proposal Defence Presentation have been published.', 1, '2026-06-18 04:24:05', NULL),
(43, 15, 'Marks Awarded', 'Evaluation marks for Proposal Defence Presentation have been published.', 1, '2026-06-18 04:24:05', NULL),
(45, 11, 'Document Uploaded', 'Group 2k23-SWEM-1 uploaded a new SRS under Proposal Defence Presentation.', 1, '2026-06-19 05:33:13', NULL),
(46, 14, 'Document Feedback Received', 'Your supervisor commented on your SRS under Proposal Defence Presentation.', 1, '2026-06-19 05:35:21', NULL),
(47, 15, 'Document Feedback Received', 'Your supervisor commented on your SRS under Proposal Defence Presentation.', 1, '2026-06-19 05:35:21', NULL),
(48, 16, 'Document Feedback Received', 'Your supervisor commented on your SRS under Proposal Defence Presentation.', 0, '2026-06-19 05:35:21', NULL),
(49, 9, 'Deadline Updated', 'The deadline for Proposal Submission has been updated to 2026-03-10T23:59.', 0, '2026-06-19 12:13:54', NULL),
(50, 10, 'Deadline Updated', 'The deadline for Proposal Submission has been updated to 2026-03-10T23:59.', 0, '2026-06-19 12:13:54', NULL),
(51, 5, 'Deadline Updated', 'The deadline for Proposal Submission has been updated to 2026-03-10T23:59.', 0, '2026-06-19 12:13:54', NULL),
(52, 6, 'Deadline Updated', 'The deadline for Proposal Submission has been updated to 2026-03-10T23:59.', 0, '2026-06-19 12:13:54', NULL),
(53, 14, 'Deadline Updated', 'The deadline for Proposal Submission has been updated to 2026-03-10T23:59.', 1, '2026-06-19 12:13:54', NULL),
(54, 7, 'Deadline Updated', 'The deadline for Proposal Submission has been updated to 2026-03-10T23:59.', 0, '2026-06-19 12:13:54', NULL),
(55, 15, 'Deadline Updated', 'The deadline for Proposal Submission has been updated to 2026-03-10T23:59.', 1, '2026-06-19 12:13:54', NULL),
(56, 16, 'Deadline Updated', 'The deadline for Proposal Submission has been updated to 2026-03-10T23:59.', 0, '2026-06-19 12:13:54', NULL),
(59, 9, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-05-10T23:59.', 0, '2026-06-19 12:15:39', NULL),
(60, 10, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-05-10T23:59.', 0, '2026-06-19 12:15:39', NULL),
(61, 5, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-05-10T23:59.', 0, '2026-06-19 12:15:39', NULL),
(62, 6, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-05-10T23:59.', 0, '2026-06-19 12:15:39', NULL),
(63, 14, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-05-10T23:59.', 1, '2026-06-19 12:15:39', NULL),
(64, 7, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-05-10T23:59.', 0, '2026-06-19 12:15:39', NULL),
(65, 15, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-05-10T23:59.', 1, '2026-06-19 12:15:39', NULL),
(66, 16, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-05-10T23:59.', 0, '2026-06-19 12:15:39', NULL),
(69, 9, 'Deadline Updated', 'The deadline for FYP Progress Presentation has been updated to 2026-12-15T23:59.', 0, '2026-06-19 12:16:12', NULL),
(70, 10, 'Deadline Updated', 'The deadline for FYP Progress Presentation has been updated to 2026-12-15T23:59.', 0, '2026-06-19 12:16:12', NULL),
(71, 5, 'Deadline Updated', 'The deadline for FYP Progress Presentation has been updated to 2026-12-15T23:59.', 0, '2026-06-19 12:16:12', NULL),
(72, 6, 'Deadline Updated', 'The deadline for FYP Progress Presentation has been updated to 2026-12-15T23:59.', 0, '2026-06-19 12:16:12', NULL),
(73, 14, 'Deadline Updated', 'The deadline for FYP Progress Presentation has been updated to 2026-12-15T23:59.', 1, '2026-06-19 12:16:12', NULL),
(74, 7, 'Deadline Updated', 'The deadline for FYP Progress Presentation has been updated to 2026-12-15T23:59.', 0, '2026-06-19 12:16:12', NULL),
(75, 15, 'Deadline Updated', 'The deadline for FYP Progress Presentation has been updated to 2026-12-15T23:59.', 1, '2026-06-19 12:16:12', NULL),
(76, 16, 'Deadline Updated', 'The deadline for FYP Progress Presentation has been updated to 2026-12-15T23:59.', 0, '2026-06-19 12:16:12', NULL),
(79, 14, 'Marks Awarded', 'Evaluation marks for Proposal Defence Presentation have been published.', 1, '2026-06-19 12:20:14', NULL),
(80, 15, 'Marks Awarded', 'Evaluation marks for Proposal Defence Presentation have been published.', 1, '2026-06-19 12:20:14', NULL),
(81, 16, 'Marks Awarded', 'Evaluation marks for Proposal Defence Presentation have been published.', 0, '2026-06-19 12:20:14', NULL),
(82, 5, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:46:57', NULL),
(83, 6, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:46:57', NULL),
(84, 7, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:46:57', NULL),
(86, 10, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:46:57', NULL),
(87, 14, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 12:46:57', NULL),
(88, 15, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 12:46:57', NULL),
(89, 16, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:46:57', NULL),
(92, 2, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 12:46:57', NULL),
(94, 5, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:47:14', NULL),
(95, 6, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:47:14', NULL),
(96, 7, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:47:14', NULL),
(98, 10, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:47:14', NULL),
(99, 14, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 12:47:14', NULL),
(100, 15, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 12:47:14', NULL),
(101, 16, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 12:47:14', NULL),
(104, 2, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 12:47:14', NULL),
(106, 5, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 0, '2026-06-19 13:50:27', NULL),
(107, 6, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 0, '2026-06-19 13:50:27', NULL),
(108, 7, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 0, '2026-06-19 13:50:27', NULL),
(110, 10, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 0, '2026-06-19 13:50:27', NULL),
(111, 14, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 1, '2026-06-19 13:50:27', NULL),
(112, 15, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 1, '2026-06-19 13:50:27', NULL),
(113, 16, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 0, '2026-06-19 13:50:27', NULL),
(115, 3, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 0, '2026-06-19 13:50:27', NULL),
(116, 11, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 1, '2026-06-19 13:50:27', NULL),
(117, 12, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 0, '2026-06-19 13:50:27', NULL),
(118, 2, 'New Department Notice', 'Notice: Extension of FYP Submission. Click to view.', 1, '2026-06-19 13:50:27', NULL),
(119, 5, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 13:55:28', NULL),
(120, 6, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 13:55:28', NULL),
(121, 7, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 13:55:28', NULL),
(123, 10, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 13:55:28', NULL),
(124, 14, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 13:55:28', NULL),
(125, 15, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 13:55:28', NULL),
(126, 16, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 13:55:28', NULL),
(129, 2, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 13:55:28', NULL),
(131, 5, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:03:50', '/notice/view?id=5'),
(132, 6, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:03:50', '/notice/view?id=5'),
(133, 7, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:03:50', '/notice/view?id=5'),
(135, 10, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:03:50', '/notice/view?id=5'),
(136, 14, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:03:50', '/notice/view?id=5'),
(137, 15, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:03:50', '/notice/view?id=5'),
(138, 16, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:03:50', '/notice/view?id=5'),
(141, 2, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:03:50', '/notice/view?id=5'),
(143, 5, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:04:04', '/notice/view?id=6'),
(144, 6, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:04:04', '/notice/view?id=6'),
(145, 7, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:04:04', '/notice/view?id=6'),
(147, 10, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:04:04', '/notice/view?id=6'),
(148, 14, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:04:04', '/notice/view?id=6'),
(149, 15, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:04:04', '/notice/view?id=6'),
(150, 16, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:04:04', '/notice/view?id=6'),
(151, 18, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:04:04', '/notice/view?id=6'),
(153, 2, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:04:04', '/notice/view?id=6'),
(155, 5, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 0, '2026-06-19 14:07:19', '/notice/view?id=7'),
(156, 6, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 0, '2026-06-19 14:07:19', '/notice/view?id=7'),
(157, 7, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 0, '2026-06-19 14:07:19', '/notice/view?id=7'),
(159, 10, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 0, '2026-06-19 14:07:19', '/notice/view?id=7'),
(160, 14, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 1, '2026-06-19 14:07:19', '/notice/view?id=7'),
(161, 15, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 1, '2026-06-19 14:07:19', '/notice/view?id=7'),
(162, 16, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 0, '2026-06-19 14:07:19', '/notice/view?id=7'),
(163, 18, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 1, '2026-06-19 14:07:19', '/notice/view?id=7'),
(164, 3, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 0, '2026-06-19 14:07:19', '/notice/view?id=7'),
(165, 11, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 1, '2026-06-19 14:07:19', '/notice/view?id=7'),
(166, 12, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 0, '2026-06-19 14:07:19', '/notice/view?id=7'),
(167, 2, 'New Department Notice', 'Notice: Extension of FYP Love. Click to view.', 1, '2026-06-19 14:07:19', '/notice/view?id=7'),
(168, 5, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:09:25', '/notice/view?id=8'),
(169, 6, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:09:25', '/notice/view?id=8'),
(170, 7, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:09:25', '/notice/view?id=8'),
(172, 10, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:09:25', '/notice/view?id=8'),
(173, 14, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:09:25', '/notice/view?id=8'),
(174, 15, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:09:25', '/notice/view?id=8'),
(175, 16, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 14:09:25', '/notice/view?id=8'),
(176, 18, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:09:25', '/notice/view?id=8'),
(178, 2, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 14:09:25', '/notice/view?id=8'),
(180, 5, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 15:22:33', '/notice/view?id=9'),
(181, 6, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 15:22:33', '/notice/view?id=9'),
(182, 7, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 15:22:33', '/notice/view?id=9'),
(184, 10, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 15:22:33', '/notice/view?id=9'),
(185, 14, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 15:22:33', '/notice/view?id=9'),
(186, 15, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 15:22:33', '/notice/view?id=9'),
(187, 16, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 0, '2026-06-19 15:22:33', '/notice/view?id=9'),
(188, 18, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 15:22:33', '/notice/view?id=9'),
(190, 2, 'New Department Notice', 'Notice: Notice: FYP Proposal Defence', 1, '2026-06-19 15:22:33', '/notice/view?id=9'),
(192, 5, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:17:22', '/notice/view?id=10'),
(193, 6, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:17:22', '/notice/view?id=10'),
(194, 7, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:17:22', '/notice/view?id=10'),
(196, 10, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:17:22', '/notice/view?id=10'),
(197, 14, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:17:22', '/notice/view?id=10'),
(198, 15, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:17:22', '/notice/view?id=10'),
(199, 16, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:17:22', '/notice/view?id=10'),
(200, 18, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:17:22', '/notice/view?id=10'),
(201, 3, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:17:22', '/notice/view?id=10'),
(202, 11, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:17:22', '/notice/view?id=10'),
(203, 12, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:17:22', '/notice/view?id=10'),
(204, 2, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:17:22', '/notice/view?id=10'),
(205, 5, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:41:39', '/notice/view?id=11'),
(206, 6, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:41:39', '/notice/view?id=11'),
(207, 7, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:41:39', '/notice/view?id=11'),
(209, 10, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:41:39', '/notice/view?id=11'),
(210, 14, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:41:39', '/notice/view?id=11'),
(211, 15, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:41:39', '/notice/view?id=11'),
(212, 16, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:41:39', '/notice/view?id=11'),
(213, 18, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:41:39', '/notice/view?id=11'),
(214, 3, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:41:39', '/notice/view?id=11'),
(215, 11, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:41:39', '/notice/view?id=11'),
(216, 12, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:41:39', '/notice/view?id=11'),
(217, 4, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:41:39', '/notice/view?id=11'),
(218, 10015, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 0, '2026-06-20 07:41:39', '/notice/view?id=11'),
(219, 2, 'New Department Notice', 'Notice: Extension of Final Year Project (FYP) Proposal Submission Date. Click to view.', 1, '2026-06-20 07:41:39', '/notice/view?id=11'),
(226, 11, 'Proposal Submitted', 'Group 2K24-SWEM-1 has submitted a project proposal selecting you as supervisor.', 1, '2026-06-21 14:26:13', NULL),
(228, 2, 'Proposal Submitted', 'Group 2K24-SWEM-1 has submitted a project proposal.', 1, '2026-06-21 14:26:13', NULL),
(229, 1, 'New Student Registration', 'Student Adil (2k23/SWE/013) registered and is pending approval.', 1, '2026-06-22 08:12:43', NULL),
(230, 9, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(231, 10, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(232, 5, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(233, 6, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(234, 10025, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(235, 14, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(236, 7, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(237, 15, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(238, 16, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 0, '2026-06-22 15:16:42', NULL),
(239, 18, 'Deadline Updated', 'The deadline for Proposal Defence Presentation has been updated to 2026-06-22T20:20.', 1, '2026-06-22 15:16:42', NULL),
(240, 14, 'Marks Awarded', 'Evaluation marks for FYP Progress Presentation have been published.', 0, '2026-06-23 03:42:42', NULL),
(241, 15, 'Marks Awarded', 'Evaluation marks for FYP Progress Presentation have been published.', 0, '2026-06-23 03:42:42', NULL),
(242, 16, 'Marks Awarded', 'Evaluation marks for FYP Progress Presentation have been published.', 0, '2026-06-23 03:42:42', NULL),
(243, 14, 'Marks Awarded', 'Evaluation marks for Final Presentation have been published.', 0, '2026-06-23 03:43:04', NULL),
(244, 15, 'Marks Awarded', 'Evaluation marks for Final Presentation have been published.', 0, '2026-06-23 03:43:04', NULL),
(245, 16, 'Marks Awarded', 'Evaluation marks for Final Presentation have been published.', 0, '2026-06-23 03:43:04', NULL),
(246, 14, 'Marks Awarded', 'Evaluation marks for Final Presentation have been published.', 0, '2026-06-23 03:43:06', NULL),
(247, 15, 'Marks Awarded', 'Evaluation marks for Final Presentation have been published.', 0, '2026-06-23 03:43:06', NULL),
(248, 16, 'Marks Awarded', 'Evaluation marks for Final Presentation have been published.', 0, '2026-06-23 03:43:06', NULL),
(249, 18, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 1, '2026-06-23 09:41:08', NULL),
(250, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 09:41:15', NULL),
(251, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 09:41:15', NULL),
(252, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 09:41:15', NULL),
(253, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:12', NULL),
(254, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:12', NULL),
(255, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:12', NULL),
(256, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:41', NULL),
(257, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:41', NULL),
(258, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:41', NULL),
(259, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:57', NULL),
(260, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:57', NULL),
(261, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:01:57', NULL),
(262, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:05:59', NULL),
(263, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:05:59', NULL),
(264, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:05:59', NULL),
(265, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:06:05', NULL),
(266, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:06:05', NULL),
(267, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:06:05', NULL),
(268, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:19:05', NULL),
(269, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:19:05', NULL),
(270, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:19:05', NULL),
(271, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:19:23', NULL),
(272, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:19:23', NULL),
(273, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:19:23', NULL),
(274, 14, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:30:01', NULL),
(275, 15, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:30:01', NULL),
(276, 16, 'Supervisor Marks Updated', 'Your supervisor has updated your manual evaluation marks.', 0, '2026-06-23 10:30:01', NULL),
(277, 18, 'Proposal Reviewed', 'Your project proposal has been Approved by your supervisor.', 1, '2026-06-23 11:08:29', NULL),
(278, 18, 'Marks Awarded', 'Evaluation marks for Proposal Defence Presentation have been published.', 0, '2026-06-23 17:02:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `user_id` int(11) NOT NULL,
  `prefix` varchar(10) NOT NULL,
  `surname` varchar(100) NOT NULL,
  `cnic` varchar(20) NOT NULL,
  `cnic_expiry` date DEFAULT NULL,
  `father_name` varchar(100) DEFAULT NULL,
  `dob` date NOT NULL,
  `mobile_code` varchar(5) NOT NULL,
  `mobile_no` varchar(15) NOT NULL,
  `place_of_birth` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `province_state` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `home_address` text NOT NULL,
  `permanent_address` text DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `gender` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`user_id`, `prefix`, `surname`, `cnic`, `cnic_expiry`, `father_name`, `dob`, `mobile_code`, `mobile_no`, `place_of_birth`, `country`, `province_state`, `district`, `city`, `home_address`, `permanent_address`, `zip_code`, `blood_group`, `gender`, `updated_at`) VALUES
(2, 'Dr.', 'Arifa Bhutto', '2222222222222', NULL, NULL, '2000-01-01', '+92', '3238962010', NULL, NULL, NULL, NULL, NULL, 'Jamshoro', NULL, NULL, NULL, 'Male', '2026-06-23 13:22:39'),
(4, 'Mr.', 'Soomro', '4444444444444', NULL, NULL, '1980-01-01', '+92', '3123451234', NULL, NULL, NULL, NULL, NULL, 'Hyderabad', NULL, NULL, NULL, 'Male', '2026-06-22 11:32:42'),
(11, 'Prof.', 'Qabulio', '1122233333334', NULL, NULL, '1980-01-01', '+92', '3238962017', NULL, NULL, NULL, NULL, NULL, 'Hyerabad', NULL, NULL, NULL, 'Male', '2026-06-22 11:34:50'),
(14, 'Mr.', 'Soomro', '4310284725235', '2029-02-28', 'Ghulam Muhammad', '2005-03-08', '+92', '3378001160', NULL, 'Pakistan', 'Sindh', 'jacobabad', 'Hyderabad', 'Somra Muhalla Jacobabad', 'Somra Muhalla Jacobabad', NULL, 'A+', 'Male', '2026-06-23 09:54:34'),
(15, 'Mr.', 'Memon', '1234567891111', NULL, 'Shafi Muhammad', '2006-06-13', '+92', '3333333333', 'Jacobabad', 'Pakistan', 'Sindh', 'jacobabad', 'Hyderabad', 'Latifabad, Phase 1, Hyderabad', 'Latifabad, Phase 1, Hyderabad', '72000', 'A+', 'Other', '2026-06-18 03:56:10'),
(16, 'Mr.', 'Something', '4310284725230', NULL, 'Someone', '2000-01-01', '+92', '3000000000', NULL, 'Pakistan', 'Sindh', 'Hyderabad', NULL, 'Not Provided Yet', NULL, NULL, NULL, 'Male', '2026-06-16 18:47:41'),
(18, 'Ms.', 'Akash', '4310284725000', NULL, 'Khalid', '2005-06-23', '+92', '3012345678', 'Jacobabad', 'Pakistan', 'Sindh', 'Hyderabad', 'Hyderabad', 'Latifabad, Phase 1, Hyderabad', 'Latifabad, Phase 1, Hyderabad', '72000', 'B-', 'Female', '2026-06-23 13:24:25'),
(10016, 'Prof.', 'Prof. Mumtaz', '5555555555556', NULL, NULL, '1985-01-01', '+92', '3780011600', NULL, NULL, NULL, NULL, NULL, 'Latifabad, Phase 1, Hyderabad', NULL, NULL, NULL, 'Male', '2026-06-22 11:40:35'),
(10025, 'Mr.', 'Soomro', '4310284720000', NULL, 'Raheem ud Din', '2000-01-01', '+92', '03123456678', NULL, 'Pakistan', 'Sindh', 'jacobabad', NULL, 'Not Provided Yet', NULL, NULL, NULL, 'Male', '2026-06-22 08:12:43');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `supervisor_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` enum('Draft','Submitted','Under Review','Approved','Rejected','Revision Requested') DEFAULT 'Draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `group_id`, `supervisor_id`, `title`, `description`, `status`, `created_at`) VALUES
(1, 1, 11, 'Learning Platform', 'Platform where student will learn new skills with low cost. here is the revised', 'Approved', '2026-06-15 15:54:27'),
(2, 4, 11, 'Web-Based Gym Management System', 'The fitness industry is experiencing rapid growth, yet many independent gymnasiums and fitness centers still rely on fragmented, manual, or paper-based systems for member management, billing, and scheduling. This reliance on outdated methods frequently leads to administrative inefficiencies, scheduling conflicts, and poor data tracking. This project proposes the development of a centralized, web-based Gym Management System designed to streamline daily operations and enhance the overall member experience.\r\n\r\nThe proposed system will feature secure, role-based dashboards tailored for administrators, trainers, and gym members. Core functionalities will include real-time membership lifecycle tracking, automated billing and subscription management, an interactive class booking workflow, and attendance monitoring. Built on a modern full-stack architecture—utilizing a responsive frontend for intuitive user navigation and a robust backend integrated with a relational database—the application ensures high data integrity and seamless scalability. By digitizing and automating these core processes, the system aims to significantly reduce administrative overhead, optimize facility resource allocation, and provide gym owners with actionable insights to drive business growth.', 'Approved', '2026-06-18 04:18:57');

-- --------------------------------------------------------

--
-- Table structure for table `proposals`
--

CREATE TABLE `proposals` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `abstract` text NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `status` enum('Draft','Submitted','Under Review','Approved','Rejected','Revision Requested') DEFAULT 'Draft',
  `feedback` text DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `proposals`
--

INSERT INTO `proposals` (`id`, `group_id`, `abstract`, `file_path`, `status`, `feedback`, `submitted_at`, `updated_at`) VALUES
(1, 1, 'Platform where student will learn new skills with low cost. here is the revised', '/uploads/proposals/1781618353_BPE.docx', 'Approved', 'please make it more unique', '2026-06-16 13:59:13', '2026-06-16 13:59:46'),
(4, 4, 'The fitness industry is experiencing rapid growth, yet many independent gymnasiums and fitness centers still rely on fragmented, manual, or paper-based systems for member management, billing, and scheduling. This reliance on outdated methods frequently leads to administrative inefficiencies, scheduling conflicts, and poor data tracking. This project proposes the development of a centralized, web-based Gym Management System designed to streamline daily operations and enhance the overall member experience.\r\n\r\nThe proposed system will feature secure, role-based dashboards tailored for administrators, trainers, and gym members. Core functionalities will include real-time membership lifecycle tracking, automated billing and subscription management, an interactive class booking workflow, and attendance monitoring. Built on a modern full-stack architecture—utilizing a responsive frontend for intuitive user navigation and a robust backend integrated with a relational database—the application ensures high data integrity and seamless scalability. By digitizing and automating these core processes, the system aims to significantly reduce administrative overhead, optimize facility resource allocation, and provide gym owners with actionable insights to drive business growth.', '/uploads/proposals/1781756337_2_month_AI-ML_Roadmap.pdf', 'Approved', 'good', '2026-06-21 14:26:13', '2026-06-23 11:08:29');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `user_id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `department` varchar(100) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `shift` enum('Morning','Evening') NOT NULL DEFAULT 'Morning'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`user_id`, `student_id`, `name`, `phone`, `department`, `avatar`, `shift`) VALUES
(5, '2k23/SWE/001', 'Kamran Khan', '0300-1234567', 'Software Engineering', NULL, 'Morning'),
(6, '2k23/SWE/002', 'Saad Siddiqui', '0312-7654321', 'Software Engineering', NULL, 'Morning'),
(7, '2k23/SWE/050', 'Amna Bibi', '0333-9876543', 'Software Engineering', NULL, 'Morning'),
(9, '2023-CS-999', 'Test Student', '1234567', 'Computer Science', NULL, 'Morning'),
(10, '2k23-SWE-24', 'akash', '0300-0000000', 'Software Engineering', NULL, 'Morning'),
(14, '2k23/SWE/048', 'Faheem Ahmed', '+923378001160', 'Software Engineering', 'avatar_1781525319_6a2feb478ec5a.png', 'Morning'),
(15, '2k23/SWE/077', 'Kamran', '+923333333333', 'Software Engineering', 'avatar_1781537125_6a30196576338.jpg', 'Morning'),
(16, '2k23/SWE/111', 'Muhammad Shaheer', '+923000000000', 'Software Engineering', 'avatar_1781635660_6a319a4cb33fd.png', 'Morning'),
(18, '2K24/SWE/033', 'Akash', '+923012345678', 'Software Engineering', 'avatar_1781756220_6a33713c3ab5a.jpg', 'Morning'),
(10025, '2k23/SWE/013', 'Adil', '+9203123456678', 'Software Engineering', 'avatar_1782115963_6a38ee7b64440.png', 'Morning');

-- --------------------------------------------------------

--
-- Table structure for table `supervisors`
--

CREATE TABLE `supervisors` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `research_interest` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `supervisors`
--

INSERT INTO `supervisors` (`user_id`, `name`, `designation`, `department`, `research_interest`) VALUES
(3, 'Faheem', 'Associate Professor', 'Software Engineering', 'Artificial Intelligence, Machine Learning, Web Engineering'),
(11, 'Mumtaz Qabulio', 'Assistant Professor', 'Software Engineering', 'AI'),
(12, 'rafiq bhutto', 'Lecturer', 'Software Engineering', ''),
(10018, 'Noorullain', 'Professor', 'Software Engineering', ''),
(10026, 'Kamran', 'Assistant Professor', 'Information Technology', 'Machine Learning');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `cnic` varchar(50) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','hod','student','supervisor','committee','coordinator') NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `cnic`, `password`, `role`, `status`, `created_at`, `reset_token`, `reset_token_expiry`) VALUES
(1, 'admin@fyp.com', '1111111111111', '$2y$12$R6aRPfeHg6u67TJswr.FieCt6g3eVLLPGxRK2WVK6dSHEjS/CyHR6', 'admin', 'approved', '2026-06-10 11:12:52', NULL, NULL),
(2, 'dean@fyp.com', '2222222222222', '$2y$12$R6aRPfeHg6u67TJswr.FieCt6g3eVLLPGxRK2WVK6dSHEjS/CyHR6', 'hod', 'approved', '2026-06-10 11:12:52', NULL, NULL),
(3, 'supervisor@fyp.com', '3333333333333', '$2y$12$R6aRPfeHg6u67TJswr.FieCt6g3eVLLPGxRK2WVK6dSHEjS/CyHR6', 'supervisor', 'approved', '2026-06-10 11:12:52', NULL, NULL),
(4, 'committee@fyp.com', '4444444444444', '$2y$12$R6aRPfeHg6u67TJswr.FieCt6g3eVLLPGxRK2WVK6dSHEjS/CyHR6', 'committee', 'approved', '2026-06-10 11:12:52', NULL, NULL),
(5, 'student1@fyp.com', '1122233333555', '$2y$12$R6aRPfeHg6u67TJswr.FieCt6g3eVLLPGxRK2WVK6dSHEjS/CyHR6', 'student', 'approved', '2026-06-10 11:12:52', NULL, NULL),
(6, 'student2@fyp.com', '6666666666666', '$2y$12$R6aRPfeHg6u67TJswr.FieCt6g3eVLLPGxRK2WVK6dSHEjS/CyHR6', 'student', 'approved', '2026-06-10 11:12:52', NULL, NULL),
(7, 'student3@fyp.com', '7777777777777', '$2y$12$R6aRPfeHg6u67TJswr.FieCt6g3eVLLPGxRK2WVK6dSHEjS/CyHR6', 'student', 'approved', '2026-06-10 11:12:52', NULL, NULL),
(9, 'teststudent@fyp.com', NULL, '$2y$12$yd08pzeqXucWsOQ9ze8xIu2uvVQ11aQiIPwRyOiDobgH0cCLE1m06', 'student', 'rejected', '2026-06-10 11:27:58', NULL, NULL),
(10, 'akash@gmail.com', NULL, '$2y$10$E..2glqnCxEx7hMkVVCZm.OIwv4dxSBo3dHF5t61tYweQS4.M.HlG', 'student', 'approved', '2026-06-13 05:44:05', NULL, NULL),
(11, 'm@gmail.com', '1122233333334', '$2y$12$VyrxSEMG76ULqZmYLe53o.Z6o9mw46.hTsoNf7.6.yV2gyGY37gBC', 'supervisor', 'approved', '2026-06-15 11:10:51', NULL, NULL),
(12, 'rafiq@fyp.com', NULL, '$2y$12$CzK0cpvuiDEMRz16puZsKeoaQ9C9bcPfG3XO8juAh/W5ZBLZJjody', 'supervisor', 'approved', '2026-06-15 11:14:17', NULL, NULL),
(14, 'faheemahmedsoomro6@gmail.com', '4310284725235', '$2y$12$p.sSTiYIwTp4MjIT2oxzYeba.3b3zLyovqluHEeukr39aSusFmb.G', 'student', 'approved', '2026-06-15 12:08:40', '303af62d00af2bd9fe40c5b8c72f813748174fa847bea4195aed2de8bb22aae7', '2026-06-19 07:51:50'),
(15, 'kami@gmail.com', '1234567891111', '$2y$12$QNmJ2Ff8tGQrSsGwBKtCEue.smYxjQ5NUemVQIvwUBsXwbbHxE5qK', 'student', 'approved', '2026-06-15 15:25:25', NULL, NULL),
(16, 'sherry@gmail.com', '4310284725230', '$2y$12$MBhSz4cD7EYSz6tw673Nbu8ilg6fW9rrJFvt3Bhb3pP1DrkJlBuq6', 'student', 'approved', '2026-06-16 18:47:41', NULL, NULL),
(18, 'mail@gmail.com', '4310284725000', '$2y$12$4hCD7ZTG6eWoJgaCT4sbiOtnGekSfRtT8/DQKAKHQbK1/SMOiYYQm', 'student', 'approved', '2026-06-18 04:17:00', NULL, NULL),
(10015, 'faheemabbasi@gmail.com', NULL, '$2y$12$67JqUKIkdAoLAfU8sAz/ce/JoNr9lCkp2X48Bg/E9jupz7iMjCmb6', 'committee', 'approved', '2026-06-19 12:19:37', NULL, NULL),
(10016, 'coordinator@fyp.com', '5555555555556', '$2y$12$R6aRPfeHg6u67TJswr.FieCt6g3eVLLPGxRK2WVK6dSHEjS/CyHR6', 'coordinator', 'approved', '2026-06-19 12:40:05', NULL, NULL),
(10018, 'noor@fyp.com', NULL, '$2y$12$Yxo7iB10Y1M2D/w7ixJoH.5lb9mQ4xTbC4WaLx8eLP6F2UdfAwpAq', 'supervisor', 'approved', '2026-06-20 07:45:41', NULL, NULL),
(10025, 'new@fyp.com', '4310284720000', '$2y$12$BR58AMqJvlOIDV7AF0e1XOAfzezjO7tfYKzI.JC4PpF.3EdUP2w2S', 'student', 'pending', '2026-06-22 08:12:43', NULL, NULL),
(10026, 'kamii@fyp.com', NULL, '$2y$12$RjfBrHLv/tekKOcupH5uZ.ld.1m6rtCgXHtw2OF1ZENq5SieiEeki', 'supervisor', 'approved', '2026-06-22 14:00:42', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `committees`
--
ALTER TABLE `committees`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `deadlines`
--
ALTER TABLE `deadlines`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stage_department` (`stage`,`department`);

--
-- Indexes for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_group_evaluator_stage` (`group_id`,`evaluator_id`,`stage`),
  ADD KEY `evaluator_id` (`evaluator_id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_code` (`group_code`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `group_members`
--
ALTER TABLE `group_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_group_student` (`group_id`,`student_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `hods`
--
ALTER TABLE `hods`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_id` (`group_id`),
  ADD KEY `supervisor_id` (`supervisor_id`);

--
-- Indexes for table `proposals`
--
ALTER TABLE `proposals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_id` (`group_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `student_id` (`student_id`);

--
-- Indexes for table `supervisors`
--
ALTER TABLE `supervisors`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `cnic` (`cnic`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `deadlines`
--
ALTER TABLE `deadlines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `evaluations`
--
ALTER TABLE `evaluations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `group_members`
--
ALTER TABLE `group_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=279;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `proposals`
--
ALTER TABLE `proposals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10027;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `committees`
--
ALTER TABLE `committees`
  ADD CONSTRAINT `committees_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD CONSTRAINT `coordinators_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD CONSTRAINT `evaluations_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluations_ibfk_2` FOREIGN KEY (`evaluator_id`) REFERENCES `committees` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `students` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_members_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `hods`
--
ALTER TABLE `hods`
  ADD CONSTRAINT `hods_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notices`
--
ALTER TABLE `notices`
  ADD CONSTRAINT `notices_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `projects_ibfk_2` FOREIGN KEY (`supervisor_id`) REFERENCES `supervisors` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `proposals`
--
ALTER TABLE `proposals`
  ADD CONSTRAINT `proposals_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supervisors`
--
ALTER TABLE `supervisors`
  ADD CONSTRAINT `supervisors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
