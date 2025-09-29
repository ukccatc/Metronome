// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Метроном';

  @override
  String get howToUse => 'Как использовать';

  @override
  String get settings => 'Настройки';

  @override
  String get play => 'Играть';

  @override
  String get pause => 'Пауза';

  @override
  String get stop => 'Стоп';

  @override
  String get bpm => 'Темп';

  @override
  String get bpmDescription =>
      'Установите темп. Большие числа = быстрее темп. Используйте кнопки +/- или нажмите на число для редактирования.';

  @override
  String get timeSignature => 'Размер';

  @override
  String get timeSignatureDescription =>
      'Установите количество долей в такте. 4/4 (Четыре четверти) самый популярный, 3/4 (Вальс) для танцев, 2/4 (Марш) для маршевой музыки.';

  @override
  String get beatSubdivision => 'Дробление долей';

  @override
  String get beatSubdivisionDescription =>
      'Выберите, как делятся доли. Четвертные (1/4) стандартные, Восьмые (1/8) играют в два раза быстрее, Триоли (1/3) создают свинговое ощущение, Шестнадцатые (1/16) очень быстрые.';

  @override
  String get accentPattern => 'Акцентный рисунок';

  @override
  String get accentPatternDescription =>
      'Выберите, какие доли подчеркиваются. Акцентированные доли играют громче и помогают почувствовать структуру ритма.';

  @override
  String get metronomeControls => 'Управление метрономом';

  @override
  String get metronomeControlsDescription =>
      'Играть/Пауза для запуска или остановки метронома. Кнопка Стоп сбрасывает на долю 1.';

  @override
  String get volume => 'Громкость';

  @override
  String get volumeDescription =>
      'Настройте громкость метронома. Большие значения делают щелчки громче.';

  @override
  String get beatIndicator => 'Индикатор долей';

  @override
  String get beatIndicatorDescription =>
      'Показывает, на какой доле вы сейчас находитесь. Выделенный круг - текущая доля.';

  @override
  String get quarter => 'Четвертные';

  @override
  String get eighth => 'Восьмые';

  @override
  String get triplet => 'Триоли';

  @override
  String get sixteenth => 'Шестнадцатые';

  @override
  String get common => 'Четыре четверти';

  @override
  String get waltz => 'Вальс';

  @override
  String get march => 'Марш';

  @override
  String get quintuple => 'Пять четвертей';

  @override
  String get none => 'Нет';

  @override
  String get firstBeat => 'Первая доля';

  @override
  String get strongWeak => 'Сильная-слабая';

  @override
  String get custom => 'Пользовательский';

  @override
  String get welcomeToMetronom => 'Добро пожаловать в Метроном!';

  @override
  String get welcomeDescription =>
      'Метроном - это профессиональное приложение-метроном, разработанное для музыкантов всех уровней. Это руководство поможет вам быстро начать работу и максимально использовать все функции.';

  @override
  String get quickStart => 'Быстрый старт (30 секунд)';

  @override
  String get step1 => 'Посмотрите на индикатор долей';

  @override
  String get step1Description =>
      'Ряд кружков вверху показывает, на какой доле вы находитесь. Выделенный круг - текущая доля.';

  @override
  String get step2 => 'Нажмите кнопку Играть';

  @override
  String get step2Description =>
      'Нажмите кнопку воспроизведения (▶️), чтобы запустить метроном. Вы услышите щелчки и увидите, как движется индикатор долей.';

  @override
  String get step3 => 'Настройте темп';

  @override
  String get step3Description =>
      'Используйте кнопки +/- рядом с числом темпа, чтобы сделать его быстрее или медленнее. Темп означает \"ударов в минуту\".';

  @override
  String get step4 => 'Начните заниматься!';

  @override
  String get step4Description =>
      'Играйте вместе с метрономом. Визуальный индикатор поможет вам держать ритм.';

  @override
  String get detailedInstructions => 'Подробные инструкции';

  @override
  String get allFeaturesExplained => 'Все функции объяснены';

  @override
  String get proTips => 'Советы профессионалов';

  @override
  String get troubleshooting => 'Решение проблем';

  @override
  String get startSlow => 'Начните медленно';

  @override
  String get startSlowDescription =>
      'Начните с медленного темпа (60-80 ударов в минуту) и постепенно увеличивайте скорость по мере улучшения.';

  @override
  String get useVisualCues => 'Используйте визуальные подсказки';

  @override
  String get useVisualCuesDescription =>
      'Следите за индикатором долей, чтобы помочь себе держать ритм, особенно при изучении новых произведений.';

  @override
  String get practiceSubdivisions => 'Тренируйте дробления';

  @override
  String get practiceSubdivisionsDescription =>
      'Используйте восьмые или шестнадцатые ноты для тренировки сложных ритмов и улучшения чувства времени.';

  @override
  String get feelTheAccents => 'Чувствуйте акценты';

  @override
  String get feelTheAccentsDescription =>
      'Используйте акцентные рисунки, чтобы понять музыкальную структуру и ощущение различных размеров.';

  @override
  String get adjustVolume => 'Настройте громкость';

  @override
  String get adjustVolumeDescription =>
      'Установите громкость так, чтобы вы могли четко слышать метроном, не заглушая свой инструмент.';

  @override
  String get noSound => 'Нет звука';

  @override
  String get noSoundSolution =>
      'Проверьте громкость устройства и настройку громкости приложения. Убедитесь, что устройство не находится в беззвучном режиме.';

  @override
  String get metronomeWontStart => 'Метроном не запускается';

  @override
  String get metronomeWontStartSolution =>
      'Попробуйте остановить и запустить снова. Убедитесь, что у вас установлен допустимый темп (40-200).';

  @override
  String get visualIndicatorNotMoving => 'Визуальный индикатор не движется';

  @override
  String get visualIndicatorNotMovingSolution =>
      'Визуальный индикатор движется только когда метроном играет. Нажмите кнопку воспроизведения для запуска.';

  @override
  String get appFeelsSlow => 'Приложение работает медленно';

  @override
  String get appFeelsSlowSolution =>
      'Закройте другие приложения, чтобы освободить память. Метроному нужно точное время для правильной работы.';
}
