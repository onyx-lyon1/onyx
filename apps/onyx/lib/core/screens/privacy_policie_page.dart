import 'package:flutter/material.dart';
import 'package:onyx/l10n/app_localizations.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).privacyPolicy),
        backgroundColor: Theme.of(context).cardColor,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppLocalizations.of(context).privacyPolicy,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context).weTakeCareOfYourData),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context).dataCollection,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context).dataOnlyStoredOnYourDevice),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context).dataSafety,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context).ourSecurityMeasures),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context).modificationOfThePrivacyPolicy,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context).weCanModifyRules),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context).contactUs,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context).ifQuestionThenGithub),
            ],
          ),
        ),
      ),
    );
  }
}
