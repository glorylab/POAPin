import 'package:poapin/common/translations/strings.dart';

class ESTranslations {
  static Map<String, String> get map => {
        'language_in_english': 'Castellano',
        'language_in_native': 'Español',
        'POAPin': 'POAPin',

        /// Tabs
        Strings.home: 'Inicio',
        Strings.watchlist: 'Lista de seguimiento',
        Strings.me: 'Yo',

        /// Home(Initial state)
        Strings.enjoy: 'Disfruta de la vida con POAP',
        Strings.setAddress:
            'Establece tu dirección y verás tus POAPs en la página de inicio',
        Strings.setEthAddress: 'Establecer dirección ETH',
        Strings.ethAddressOrEns: 'Dirección ETH o ENS',
        Strings.invalidAddress: 'Dirección no válida',

        /// Home(empty)
        Strings.noPoap:
            'Parece que no tienes ningún POAP ahora.\nPero aún no es tarde!\n\nComienza a aprender sobre POAP creando un POAP.',

        /// Home(available)
        Strings.followers: 'seguidores',
        Strings.followings: 'siguiendo',
        Strings.events: 'Eventos',
        Strings.poaps: 'POAPs',
        Strings.growth: 'crecimiento',
        Strings.monthly: 'mensual',
        Strings.filterHint: 'Filtrar por nombre, descripción, ubicación, etc.',
        // --- Prefs
        Strings.visibility: 'Visibilidad',
        Strings.hideDuplicates: 'Ocultar duplicados',
        Strings.showAll: 'Mostrar todo',
        Strings.sort: 'Ordenar',
        Strings.newest: 'Más reciente',
        Strings.oldest: 'Más antiguo',
        Strings.shape: 'Forma',
        Strings.square: 'Cuadrado',
        Strings.round: 'Redondo',
        Strings.layout: 'Diseño',
        Strings.grid: 'Cuadrícula',
        Strings.list: 'Lista',
        Strings.timeline: 'Cronología',
        // --- Filter
        Strings.filter: 'Filtrar',
        Strings.filterTitle: 'Título',
        Strings.filterDescription: 'Descripción',
        Strings.filterCountry: 'País',
        Strings.filterTag: 'Etiqueta',
        Strings.filterChain: 'Cadena',
        Strings.filterClearAll: 'Borrar todo',

        /// Home(edit mode)
        Strings.editMode: 'Editar POAPs',
        Strings.editTags: 'Editar etiquetas',
        Strings.newTag: 'Nueva Etiqueta',
        Strings.newTagHint: 'nueva etiqueta para el evento',

        /// Moments
        Strings.momentsDesc:
            '''Tu colección de POAP es tu identificación digital.
        
        Muestra al mundo quién eres: dónde has estado, qué has logrado y con quién te has encontrado.
        
        Los momentos es una manera de agregar valor real a tu marcador digital guardando instancias de la vida real en un POAP, para siempre.
        ''',
        Strings.uploadMoments: 'Subir momentos en welook.io',

        /// GitPOAP
        Strings.gitPoapDesc:
            '''Un GitPOAP es un POAP regular (con un giro extra) que se acuña a través de la plataforma GitPOAP para contribuciones significativas especificadas en proyectos de código abierto. Los propietarios de los repositorios distribuyen automáticamente los GitPOAPs a sus contribuyentes como reconocimiento a su trabajo.
        ''',
        Strings.gitPoapStart: 'Contribuir a POAPin',

        /// Watchlist(Initial state)
        Strings.watchlistHint:
            'Aquí puedes agregar algunas direcciones que te interesan.',
        Strings.addCollection: 'Agregar tu primera colección',

        /// Watchlist(available)
        Strings.follow: 'Seguir',
        Strings.unfollow: 'Dejar de seguir',

        /// Me
        Strings.connectWalletHint:
            'Inicia sesión con el navegador y conecta la cartera.',

        /// Profile
        Strings.profile: 'Perfil',
        Strings.dangerZone: 'Zona de peligro',
        Strings.deleteAccount: 'Eliminar cuenta',
        Strings.deleteAccountDesc:
            '¿Estás seguro de que quieres eliminar tu cuenta?\n\nEsta operación no se puede deshacer.',
        Strings.deleteAccountConfirm: 'Eliminar',

        /// Tags
        Strings.tags: 'Etiquetas',
        Strings.manageTags: 'Administrar tus etiquetas',
        Strings.noTags: 'Aún no hay etiquetas',
        Strings.addTag: 'Nueva Etiqueta',
        Strings.editTagHint: 'elige de arriba\no',

        /// Journal
        // Strings.journal: 'Journal',

        /// Settings
        Strings.settings: 'Configuración',
        Strings.settingsDesc: 'Notificaciones, datos, etc.',
        Strings.notification: 'Notificación',
        Strings.notificationEmail: 'Correo electrónico',
        Strings.notificationEmailDesc:
            'Recibir notificaciones por correo electrónico',
        Strings.notificationApp: 'Aplicación',
        Strings.notificationAppDesc: 'Recibir notificaciones de la aplicación',
        Strings.notificationAppThisDevice: 'Este dispositivo',
        Strings.notificationAppDescMore:
            'Recibir notificaciones de la aplicación',
        Strings.notificationBrowser: 'Navegador',
        Strings.notificationBrowserDesc: 'Recibir notificaciones del navegador',
        Strings.notificationPush: 'Push',
        Strings.notificationPushDesc: 'Recibir notificaciones push',
        Strings.general: 'General',
        Strings.language: 'Idioma',
        Strings.contributeLanguage: '🙇 Contribuir con más traducciones 🔗',
        Strings.data: 'General',
        Strings.cache: 'Borrar todo el caché',
        Strings.cacheDesc:
            'Si hay problemas con la aplicación, por favor inténtalo.',
        Strings.about: 'Acerca de',

        /// Account
        Strings.signIn: 'Iniciar sesión',
        Strings.logOut: 'Cerrar sesión',
        Strings.signInApple: 'Iniciar sesión con Apple',
        Strings.signInGoogle: 'Continuar con Google',
        Strings.tos:
            'Al continuar, aceptas nuestros Términos de servicio y Política de privacidad',

        /// Common
        Strings.done: 'Hecho',
        Strings.alert: 'Alerta',
        Strings.error: 'Error',
        Strings.learnMore: 'aprende más',
        // --- Months
        Strings.january: 'Enero',
        Strings.february: 'Febrero',
        Strings.march: 'Marzo',
        Strings.april: 'Abril',
        Strings.may: 'Mayo',
        Strings.june: 'Junio',
        Strings.july: 'Julio',
        Strings.august: 'Agosto',
        Strings.september: 'Septiembre',
        Strings.october: 'Octubre',
        Strings.november: 'Noviembre',
        Strings.december: 'Diciembre',
      };
}
