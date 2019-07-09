import 'package:delern_flutter/l10n/messages_all.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(String locale) async {
    final localeName = Intl.canonicalizedLocale(locale);

    await initializeMessages(localeName);
    await initializeDateFormatting(localeName);
    Intl.defaultLocale = localeName;

    return AppLocalizations();
  }

  String get navigationDrawerSignOut => Intl.message(
        'Sign Out',
        name: 'navigationDrawerSignOut',
        desc: 'Sign Out in Navigation Drawer',
      );

  String get navigationDrawerCommunicateGroup => Intl.message(
        'Communicate',
        name: 'navigationDrawerCommunicateGroup',
        desc: 'Communicate Group Name in Navigation Drawer',
      );

  String get navigationDrawerInviteFriends => Intl.message(
        'Invite Friends',
        name: 'navigationDrawerInviteFriends',
        desc: 'Invite Friends in Navigation Drawer',
      );

  String get navigationDrawerContactUs => Intl.message(
        'Contact Us',
        name: 'navigationDrawerContactUs',
        desc: 'Contact Us in Navigation Drawer',
      );

  String get navigationDrawerSupportDevelopment => Intl.message(
        'Support Development',
        name: 'navigationDrawerSupportDevelopment',
        desc: 'Support Development in Navigation Drawer',
      );

  String get navigationDrawerAbout => Intl.message(
        'About',
        name: 'navigationDrawerAbout',
        desc: 'About in Navigation Drawer',
      );

  String get signInWithGoogle => Intl.message(
        'Sign in with Google',
        name: 'signInWithGoogle',
        desc: 'Sign in with Google Button',
      );

  String get editCardsDeckMenu => Intl.message(
        'Edit Cards',
        name: 'editCardsDeckMenu',
        desc: 'Edit Cards in Deck Menu',
      );

  String get settingsDeckMenu => Intl.message(
        'Settings',
        name: 'settingsDeckMenu',
        desc: 'Settings in Deck Menu',
      );

  String get shareDeckMenu => Intl.message(
        'Share',
        name: 'shareDeckMenu',
        desc: 'Share in Deck Menu',
      );

  String numberOfCards(int number) => Intl.message(
        'Number of cards: $number',
        name: 'numberOfCards',
        args: [number],
        desc: 'Number of cards',
      );

  String get canEdit => Intl.message(
        'Can Edit',
        name: 'canEdit',
        desc: 'User can edit a deck',
      );

  String get canView => Intl.message(
        'Can View',
        name: 'canView',
        desc: 'User can view a deck',
      );

  String get owner => Intl.message(
        'Owner',
        name: 'owner',
        desc: 'User has owner access',
      );

  String get noAccess => Intl.message(
        'No access',
        name: 'noAccess',
        desc: 'User has no access',
      );

  String get emailAddressHint => Intl.message(
        'Email address',
        name: 'emailAddressHint',
        desc: 'Email address hint',
      );

  String get peopleLabel => Intl.message(
        'People',
        name: 'peopleLabel',
        desc: 'People label',
      );

  String get whoHasAccessLabel => Intl.message(
        'Who has access',
        name: 'whoHasAccessLabel',
        desc: 'Who has access label',
      );

  String get frontSideHint => Intl.message(
        'Front side',
        name: 'frontSideHint',
        desc: 'front side',
      );

  String get backSideHint => Intl.message(
        'Back side',
        name: 'backSideHint',
        desc: 'back side',
      );

  String get reversedCardLabel => Intl.message(
        'Add reversed card',
        name: 'reversedCardLabel',
        desc: 'Add reversed card',
      );

  String get deck => Intl.message(
        'Deck',
        name: 'deck',
        desc: 'Deck label',
      );

  String get add => Intl.message(
        'Add',
        name: 'add',
        desc: 'Add',
      );

  String get save => Intl.message(
        'Save',
        name: 'save',
        desc: 'Save',
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        desc: 'Delete',
      );

  String get saveChangesQuestion => Intl.message(
        'Do you want to save changes?',
        name: 'saveChangesQuestion',
        desc: 'Do you want to save changes?',
      );

  String get deleteCardQuestion => Intl.message(
        'Do you want to delete this card?',
        name: 'deleteCardQuestion',
        desc: 'Do you want to delete card?',
      );

  String get errorUserMessage => Intl.message(
        'Error: ',
        name: 'errorUserMessage',
        desc: 'Error occurred.',
      );

  String get send => Intl.message(
        'Send',
        name: 'send',
        desc: 'Send',
      );

  String get appNotInstalledSharingDeck => Intl.message(
        'This user hasn\'t installed Delern yet. Do you want to sent an '
        'invite?',
        name: 'appNotInstalledSharingDeck',
        desc: 'The app hasn\'t installed by user with who deck was shared',
      );

  String get inviteToAppMessage => Intl.message(
        '''I invite you to install Delern, a spaced repetition learning app, which will allow you to learn quickly and easily!

Proceed to install it from:
Google Play: https://play.google.com/store/apps/details?id=org.dasfoo.delern
App Store: https://itunes.apple.com/us/app/delern/id1435734822?ls=1&mt=8

After install, follow Delern latest news on:
Facebook: https://fb.me/das.delern
VK: https://vk.com/delern
Twitter: https://twitter.com/dasdelern''',
        name: 'inviteToAppMessage',
        desc: 'Invite to the App message',
      );

  String get edit => Intl.message(
        'Edit',
        name: 'edit',
        desc: 'Edit',
      );

  String watchedCards(int number) => Intl.message(
        'Watched: $number',
        args: [number],
        name: 'watchedCards',
        desc: 'watchedCards',
      );

  String get basicDeckType => Intl.message(
        'Basic',
        name: 'basicDeckType',
        desc: 'basic decktype name',
      );

  String get germanDeckType => Intl.message(
        'German',
        name: 'germanDeckType',
        desc: 'german decktype name',
      );

  String get swissDeckType => Intl.message(
        'Swiss',
        name: 'swissDeckType',
        desc: 'swiss decktype name',
      );

  String get deckType => Intl.message(
        'Deck Type',
        name: 'deckType',
        desc: 'Deck Type',
      );

  String get markdown => Intl.message(
        'Markdown',
        name: 'markdown',
        desc: 'Markdown',
      );

  String get cardDeletedUserMessage => Intl.message(
        'Card was deleted',
        name: 'cardDeletedUserMessage',
        desc: 'Card was deleted',
      );

  String get cardAddedUserMessage => Intl.message(
        'Card was added',
        name: 'cardAddedUserMessage',
        desc: 'Card was added',
      );

  String get searchHint => Intl.message(
        'Search...',
        name: 'searchHint',
        desc: 'Search...',
      );

  String get emptyUserSharingList => Intl.message(
        'Share your deck',
        name: 'emptyUserSharingList',
        desc: 'Share your deck',
      );

  String get emptyDecksList => Intl.message(
        'Add your decks',
        name: 'emptyDecksList',
        desc: 'Add your decks',
      );

  String get emptyCardsList => Intl.message(
        'Add your cards',
        name: 'emptyCardsList',
        desc: 'Add your cards',
      );

  String get noSharingAccessUserMessage => Intl.message(
        'Only owner of deck can share it.',
        name: 'noSharingAccessUserMessage',
        desc: 'Only owner of deck can share it.',
      );

  String get noEditingWithReadAccessUserMessage => Intl.message(
        'You cannot edit card with a read access.',
        name: 'noEditingWithReadAccessUserMessage',
        desc: 'You cannot edit card with a read access.',
      );

  String get noDeletingWithReadAccessUserMessage => Intl.message(
        'You cannot delete card with a read access.',
        name: 'noDeletingWithReadAccessUserMessage',
        desc: 'You cannot delete card with a read access.',
      );

  String get noAddingWithReadAccessUserMessage => Intl.message(
        'You cannot add cards with a read access.',
        name: 'noAddingWithReadAccessUserMessage',
        desc: 'You cannot add cards with a read access..',
      );

  String get continueEditingQuestion => Intl.message(
        'You have unsaved changes. Would you like to continue editing?',
        name: 'continueEditingQuestion',
        desc: 'You have unsaved changes. Would you like to continue editing?',
      );

  String get yes => Intl.message(
        'Yes',
        name: 'yes',
        desc: 'Yes',
      );

  String get discard => Intl.message(
        'Discard',
        name: 'discard',
        desc: 'Discard',
      );

  String get supportDevelopment => Intl.message(
        '''
Please tell us what we can do to make your experience with Delern better!

If you have any questions or suggestions please contact us:
[delern@dasfoo.org](mailto:delern@dasfoo.org)

Follow latest news on:

- [Facebook](https://fb.me/das.delern)
- [Twitter](https://twitter.com/dasdelern)
- [VK](https://vk.com/delern)

To see the source code for this app, please visit the [Delern GitHub repo](https://github.com/dasfoo/delern).
      ''',
        name: 'supportDevelopment',
        desc: 'Support Development',
      );

  String get installEmailApp => Intl.message(
        'Please install Email App',
        name: 'installEmailApp',
        desc: 'Please install Email App',
      );

  String couldNotLaunchUrl(String url) => Intl.message(
        'Could not launch url $url',
        args: [url],
        name: 'couldNotLaunchUrl',
        desc: 'Could not launch url',
      );

  String get no => Intl.message(
        'no',
        name: 'no',
        desc: 'no',
      );

  String continueLearningQuestion(String date) => Intl.message(
        'Next card to learn is suggested at $date. Would you like to continue '
        'learning anyway?',
        args: [date],
        name: 'continueLearningQuestion',
        desc: 'Question for the user to continue learning',
      );

  String get offlineUserMessage => Intl.message(
        'You are offline, please try it later',
        name: 'offlineUserMessage',
        desc: 'Offline user message',
      );

  String get serverUnavailableUserMessage => Intl.message(
        'Server temporarily unavailable, please try again later',
        name: 'serverUnavailableUserMessage',
        desc: 'Server temporarily unavailable',
      );

  String get doNotNeedFeaturesText => Intl.message(
        'I do not want any of these features',
        name: 'doNotNeedFeaturesText',
        desc: 'Do not need features text',
      );

  String get continueAnonymously => Intl.message(
        'Continue Anonymously',
        name: 'continueAnonymously',
        desc: 'Continue Anonymously',
      );

  String get splashScreenFeatures => Intl.message(
        'Data and progress are saved in the Cloud\n'
        'Data and progress are synchronized across all your devices\n'
        'Share cards with your friends and colleagues',
        name: 'splashScreenFeatures',
        desc: 'Data and progress are saved',
      );

  String get anonymous => Intl.message(
        'Anonymous',
        name: 'anonymous',
        desc: 'Anonymous',
      );

  String get navigationDrawerSignIn => Intl.message(
        'Sign In',
        name: 'navigationDrawerSignIn',
        desc: 'Sign In',
      );

  String get accountExistUserWarning => Intl.message(
        'You already have an account, please sign in with your credentials. '
        'All your data, that was created anonymously, will be lost. '
        'Would you like to continue?',
        name: 'accountExistUserWarning',
        desc: 'User warning, account already exists',
      );

  String get deleteDeckOwnerAccessQuestion => Intl.message(
        'The deck, all cards and learning history will be removed.\n\n'
        'If you have shared this deck with other users, it will also be '
        'removed from all users it is shared with. Do you want to delete '
        'deck?',
        name: 'deleteDeckOwnerAccessQuestion',
        desc: 'Delete deck question to owner of deck',
      );

  String get deleteDeckWriteReadAccessQuestion => Intl.message(
        'The deck will be removed from your account only, all cards and '
        'learning history will remain with the owner and other users. '
        'Do you want to delete deck?',
        name: 'deleteDeckWriteReadAccessQuestion',
        desc: 'Delete deck question to user with write access',
      );

  String get decksIntroTitle => Intl.message(
        'Create Decks',
        name: 'decksIntroTitle',
        desc: 'Create decks intro title',
      );

  String get decksIntroDescription => Intl.message(
        'Create decks with flashcards',
        name: 'decksIntroDescription',
        desc: 'Create decks with flashcards',
      );

  String get learnIntroTitle => Intl.message(
        'Learn',
        name: 'learnIntroTitle',
        desc: 'Learn intro title',
      );

  String get learnIntroDescription => Intl.message(
        'Learn in any place and offline as well',
        name: 'learnIntroDescription',
        desc: 'Learn intro description',
      );

  String get shareIntroTitle => Intl.message(
        'Share decks',
        name: 'shareIntroTitle',
        desc: 'Share intro title',
      );

  String get shareIntroDescription => Intl.message(
        'Share decks with friends and colleagues to learn together',
        name: 'shareIntroDescription',
        desc: 'Share intro description',
      );

  String get done => Intl.message(
        'Done',
        name: 'done',
        desc: 'Done',
      );

  String get skip => Intl.message(
        'Skip',
        name: 'skip',
        desc: 'Skip',
      );

  String get appLogoName => Intl.message(
        'Delern Flashcards',
        name: 'appLogoName',
        desc: 'Delern Flashcards',
      );

  String get addCardsDeckMenu => Intl.message(
        'Add Cards',
        name: 'addCardsDeckMenu',
        desc: 'Add Cards in Deck Menu',
      );

  String get addDeckTooltip => Intl.message(
        'Add Deck',
        name: 'addDeckTooltip',
        desc: 'Add Deck',
      );

  String get addCardTooltip => Intl.message(
        'Add Card',
        name: 'addCardTooltip',
        desc: 'Add Card',
      );

  String get cardAndReversedAddedUserMessage => Intl.message(
        'Card and reversed card were added',
        name: 'cardAndReversedAddedUserMessage',
        desc: 'Card and reversed card were added',
      );

  String get listOFDecksScreenTitle => Intl.message(
        'List of decks',
        name: 'listOFDecksScreenTitle',
        desc: 'List of decks',
      );

  String cardsToLearnLabel(String numberOfCards) => Intl.message(
        '$numberOfCards to learn',
        args: [numberOfCards],
        name: 'cardsToLearnLabel',
        desc: 'Cards to learn label',
      );

  String get profileTooltip => Intl.message(
        'Profile',
        name: 'profileTooltip',
        desc: 'Profile tooltip',
      );

  String get deckDeletedUserMessage => Intl.message(
        'Deck was deleted',
        name: 'deckDeletedUserMessage',
        desc: 'Deck was deleted',
      );

  String get imageFromGalleryLabel => Intl.message(
        'From Gallery',
        name: 'imageFromGalleryLabel',
        desc: 'Upload image from Gallery',
      );

  String get imageFromPhotoLabel => Intl.message(
        'Take Photo',
        name: 'imageFromPhotoLabel',
        desc: 'Take photo to upload image',
      );

  String get accessibilityAddImageLabel => Intl.message(
        'Add Image',
        name: 'accessibilityAddImageLabel',
        desc: 'Add Image Accessibility label',
      );
}
