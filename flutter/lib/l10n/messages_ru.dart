// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'ru';

  static m0(numberOfCards) => "${numberOfCards} на изучение";

  static m1(date) =>
      "Следующая карточка рекомендуется к повторению ${date}. Вы хотите продолжить изучение?";

  static m2(url) => "Не удалось запустить ссылку ${url}";

  static m3(number) => "Количество карточек: ${number}";

  static m4(number) => "Просмотрено: ${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "accessibilityAddImageLabel":
            MessageLookupByLibrary.simpleMessage("Добавить картинку"),
        "accountExistUserWarning": MessageLookupByLibrary.simpleMessage(
            "У Вас уже есть учетная запись, пожалуйста, войдите в свой аккаунт. Все ваши данные, созданные анонимно, будут потеряны. Желаете ли Вы продолжить?"),
        "add": MessageLookupByLibrary.simpleMessage("Добавить"),
        "addCardTooltip":
            MessageLookupByLibrary.simpleMessage("Добавить карточку"),
        "addCardsDeckMenu":
            MessageLookupByLibrary.simpleMessage("Добавить карточки"),
        "addDeckTooltip":
            MessageLookupByLibrary.simpleMessage("Добавить список"),
        "anonymous":
            MessageLookupByLibrary.simpleMessage("Анонимный пользователь"),
        "appLogoName":
            MessageLookupByLibrary.simpleMessage("Delern Флэшкарточки"),
        "appNotInstalledSharingDeck": MessageLookupByLibrary.simpleMessage(
            "Данный пользователь еще не установил Delern. Отправить приглашение?"),
        "backSideHint":
            MessageLookupByLibrary.simpleMessage("Обратная сторона"),
        "basicDeckType": MessageLookupByLibrary.simpleMessage("Базовый"),
        "canEdit": MessageLookupByLibrary.simpleMessage("Может редактировать"),
        "canView": MessageLookupByLibrary.simpleMessage("Может просматривать"),
        "cardAddedUserMessage":
            MessageLookupByLibrary.simpleMessage("Карточка добавлена"),
        "cardAndReversedAddedUserMessage": MessageLookupByLibrary.simpleMessage(
            "Карточка и обратная карточка были добавлены"),
        "cardDeletedUserMessage":
            MessageLookupByLibrary.simpleMessage("Карточка удалена"),
        "cardsToLearnLabel": m0,
        "continueAnonymously":
            MessageLookupByLibrary.simpleMessage("Продолжить Анонимно"),
        "continueEditingQuestion": MessageLookupByLibrary.simpleMessage(
            "У Вас есть несохраненные изменения. Хотите продолжить редактирование?"),
        "continueLearningQuestion": m1,
        "couldNotLaunchUrl": m2,
        "deck": MessageLookupByLibrary.simpleMessage("Список"),
        "deckDeletedUserMessage":
            MessageLookupByLibrary.simpleMessage("Список был удален"),
        "deckType": MessageLookupByLibrary.simpleMessage("Тип списка"),
        "decksIntroDescription": MessageLookupByLibrary.simpleMessage(
            "Создавайте списки с карточками"),
        "decksIntroTitle":
            MessageLookupByLibrary.simpleMessage("Создавайте списки"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "deleteCardQuestion": MessageLookupByLibrary.simpleMessage(
            "Вы хотите удалить эту карточку?"),
        "deleteDeckOwnerAccessQuestion": MessageLookupByLibrary.simpleMessage(
            "Список, все карточки и история изучения будут удалены.\n\nЕсли вы поделились списком с другими пользователями, он также будет удален у них. Вы хотите удалить список?"),
        "deleteDeckWriteReadAccessQuestion": MessageLookupByLibrary.simpleMessage(
            "Список будет удален с Вашего аккаунта, все карточки и история изучения останутся у владельца списка и остальных пользователей. Вы хотите удалить список?"),
        "discard": MessageLookupByLibrary.simpleMessage("Отменить изменения"),
        "doNotNeedFeaturesText": MessageLookupByLibrary.simpleMessage(
            "Мне не нужны все эти функции "),
        "done": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
        "editCardsDeckMenu":
            MessageLookupByLibrary.simpleMessage("Редактировать карточки"),
        "emailAddressHint":
            MessageLookupByLibrary.simpleMessage("Адрес электронной почты"),
        "emptyCardsList":
            MessageLookupByLibrary.simpleMessage("Добавьте карточки"),
        "emptyDecksList":
            MessageLookupByLibrary.simpleMessage("Добавьте списки"),
        "emptyUserSharingList":
            MessageLookupByLibrary.simpleMessage("Поделитесь списком"),
        "errorUserMessage":
            MessageLookupByLibrary.simpleMessage("Произошла ошибка: "),
        "frontSideHint":
            MessageLookupByLibrary.simpleMessage("Передняя сторона"),
        "germanDeckType": MessageLookupByLibrary.simpleMessage("Немецкий"),
        "imageFromGalleryLabel":
            MessageLookupByLibrary.simpleMessage("Из Галереи"),
        "imageFromPhotoLabel":
            MessageLookupByLibrary.simpleMessage("Сфотографировать"),
        "installEmailApp": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста установите приложение Электронной Почты"),
        "inviteToAppMessage": MessageLookupByLibrary.simpleMessage(
            "Я приглашаю Вас установить Delern, систему интервального изучения, которая позволяет изучать быстро и легко!\n\nПройдите по ссылке чтобы установить из\nGoogle Play: https://play.google.com/store/apps/details?id=org.dasfoo.delern\nApp Store: https://itunes.apple.com/us/app/delern/id1435734822?ls=1&mt=8\n\nПосле установки, следите за последними новостями Delern:\nFacebook: https://fb.me/das.delern\nVK: https://vk.com/delern\nTwitter: https://twitter.com/dasdelern"),
        "learnIntroDescription": MessageLookupByLibrary.simpleMessage(
            "Изучайте в любом месте, а также без сети"),
        "learnIntroTitle": MessageLookupByLibrary.simpleMessage("Изучайте"),
        "listOFDecksScreenTitle":
            MessageLookupByLibrary.simpleMessage("Список папок"),
        "markdown": MessageLookupByLibrary.simpleMessage("Маркдаун"),
        "navigationDrawerAbout":
            MessageLookupByLibrary.simpleMessage("О приложении"),
        "navigationDrawerCommunicateGroup":
            MessageLookupByLibrary.simpleMessage("Общение"),
        "navigationDrawerContactUs":
            MessageLookupByLibrary.simpleMessage("Связаться с нами"),
        "navigationDrawerInviteFriends":
            MessageLookupByLibrary.simpleMessage("Пригласить друзей"),
        "navigationDrawerSignIn": MessageLookupByLibrary.simpleMessage("Войти"),
        "navigationDrawerSignOut":
            MessageLookupByLibrary.simpleMessage("Выход"),
        "navigationDrawerSupportDevelopment":
            MessageLookupByLibrary.simpleMessage("Поддержать разработку"),
        "no": MessageLookupByLibrary.simpleMessage("нет"),
        "noAccess": MessageLookupByLibrary.simpleMessage("Нет доступа"),
        "noAddingWithReadAccessUserMessage":
            MessageLookupByLibrary.simpleMessage(
                "Вы не можете добавлять карточки с доступом на чтение."),
        "noDeletingWithReadAccessUserMessage":
            MessageLookupByLibrary.simpleMessage(
                "Вы не можете удалить карточки с доступом на чтение."),
        "noEditingWithReadAccessUserMessage":
            MessageLookupByLibrary.simpleMessage(
                "Вы не можете редактировать карточки с доступом на чтение."),
        "noSharingAccessUserMessage": MessageLookupByLibrary.simpleMessage(
            "Только владелец может поделиться списком."),
        "numberOfCards": m3,
        "offlineUserMessage": MessageLookupByLibrary.simpleMessage(
            "Нет сети, пожалуйста, попробуйте позже"),
        "owner": MessageLookupByLibrary.simpleMessage("Владелец"),
        "peopleLabel": MessageLookupByLibrary.simpleMessage("Люди"),
        "profileTooltip": MessageLookupByLibrary.simpleMessage("Профиль"),
        "reversedCardLabel":
            MessageLookupByLibrary.simpleMessage("Добавить обратную карточку"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "saveChangesQuestion": MessageLookupByLibrary.simpleMessage(
            "Вы хотите сохранить изменения?"),
        "searchHint": MessageLookupByLibrary.simpleMessage("Поиск..."),
        "send": MessageLookupByLibrary.simpleMessage("Отправить"),
        "serverUnavailableUserMessage": MessageLookupByLibrary.simpleMessage(
            "Сервер временно недоступен, пожалуйста, попробуйте позже"),
        "settingsDeckMenu": MessageLookupByLibrary.simpleMessage("Настройки"),
        "shareDeckMenu": MessageLookupByLibrary.simpleMessage("Поделиться"),
        "shareIntroDescription": MessageLookupByLibrary.simpleMessage(
            "Делитесь списками с друзьями и коллегами, чтобы изучать вместе"),
        "shareIntroTitle":
            MessageLookupByLibrary.simpleMessage("Делитесь списками"),
        "signInWithGoogle":
            MessageLookupByLibrary.simpleMessage("Войти с помощью Google"),
        "skip": MessageLookupByLibrary.simpleMessage("Пропустить"),
        "splashScreenFeatures": MessageLookupByLibrary.simpleMessage(
            "Данные и прогресс сохранены в Облаке\nДанные и прогресс синхронизированы на всех Ваших устройствах\nДелитесь карточками со своими друзьями и коллегами"),
        "supportDevelopment": MessageLookupByLibrary.simpleMessage(
            "Расскажите, пожалуйста, что мы можем сделать, чтобы улучшить Ваш опыт с Delern!\n\nЕсли у вас есть какие-либо вопросы или предложения, свяжитесь с нами:\n[delern@dasfoo.org](mailto:delern@dasfoo.org)\n\nCледите за последними новостями Delern:\n\n- [Facebook](https://fb.me/das.delern)\n- [Twitter](https://twitter.com/dasdelern)\n- [VK](https://vk.com/delern)\n\nЧтобы увидеть исходный код этого приложения, посетите [Delern GitHub repo](https://github.com/dasfoo/delern).\n      "),
        "swissDeckType": MessageLookupByLibrary.simpleMessage("Швейцарский"),
        "watchedCards": m4,
        "whoHasAccessLabel":
            MessageLookupByLibrary.simpleMessage("У кого есть доступ"),
        "yes": MessageLookupByLibrary.simpleMessage("Да")
      };
}
