![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)
![SPM](https://img.shields.io/badge/SPM-964B00?style=for-the-badge&logo=Xcode&logoColor=white)
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
<br/>
![Target](https://img.shields.io/badge/iOS-12+-blue)
![Version](https://img.shields.io/badge/version-2.0.0-blue)
<br/>
![OSLog](https://img.shields.io/badge/-OSLog-blue)

# DTLogger

Логгер основанный на `OSLog` для более удобного отслеживания событий через приложение консоль.

### News
**v.2.0.0 (24.09.2023)**
- Логгер был переписан и реализован через класс
- Структура SystemLogger была depricated, вместо него нужно использовать SysLogger
- Добавлен новый уровень
- Убран разделитель "=======", так как в Xcode 15 консоль и без него читается удобно

## Установка
Для установки, скопируйте ссылку на репозиторий и добавьте зависимость в SPM
```
https://github.com/ZyFun/DTLogger.git
```

## Использование
```Swift
import DTLogger

let logger = DTLogger.shared
logger.log(.info, "Message")
```
</br>
При использовании логгера, в консоли будет отображаться информация с названием файла, строкой и методом, в котором логгер был использован. Это позводит быстрее ориентироваться в проекте, когда что-то идёт не так.
</br>
</br>

Есть 4 типа важности
```Swift
- info
- warning
- error
- debug
```
