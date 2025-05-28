// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../providers/profile_provider.dart';

// class ProfilePage extends ConsumerWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final profileAsync = ref.watch(driverProfileProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Profil Driver')),
//       body: profileAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text('Error: $e')),
//         data: (profile) => Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Nama     : ${profile.name}', style: Theme.of(context).textTheme.bodyLarge),
//               const SizedBox(height: 8),
//               Text('Email    : ${profile.email}', style: Theme.of(context).textTheme.bodyLarge),
//               const SizedBox(height: 8),
//               Text('No Angkot: ${profile.route}', style: Theme.of(context).textTheme.bodyLarge),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
