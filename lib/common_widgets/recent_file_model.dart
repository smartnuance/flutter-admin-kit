class RecentFile {
  final String icon, title, date, size;

  RecentFile(
      {required this.icon,
      required this.title,
      required this.date,
      required this.size});
}

List demoRecentFiles = <RecentFile>[
  RecentFile(
    icon: 'assets/icons/doc_file.svg',
    title: 'Document',
    date: '23-02-2021',
    size: '32.5mb',
  ),
  RecentFile(
    icon: 'assets/icons/sound_file.svg',
    title: 'Sound File',
    date: '21-02-2021',
    size: '3.5mb',
  ),
  RecentFile(
    icon: 'assets/icons/media_file.svg',
    title: 'Media File',
    date: '23-02-2021',
    size: '2.5gb',
  ),
  RecentFile(
    icon: 'assets/icons/pdf_file.svg',
    title: 'PDF',
    date: '25-02-2021',
    size: '3.5mb',
  ),
  RecentFile(
    icon: 'assets/icons/spreadsheet_file.svg',
    title: 'Spreadsheet',
    date: '25-02-2021',
    size: '34.5mb',
  ),
];
