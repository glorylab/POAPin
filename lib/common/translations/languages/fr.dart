import 'package:poapin/common/translations/strings.dart';

class FRTranslations {
  static Map<String, String> get map => {
        'language_in_english': 'French',
        'language_in_native': 'Français',
        'POAPin': 'POAPin',

        /// Tabs
        Strings.home: 'Accueil',
        Strings.watchlist: 'Watchlist',
        Strings.me: 'Moi',

        /// Home(Initial state)
        Strings.enjoy: 'Une vie pleine de POAPs.',
        Strings.setAddress:
            'Entrez votre adresse et vous verrez vos POAPs sur la page d\'accueil.',
        Strings.setEthAddress: 'Définir l\'adresse ETH',
        Strings.ethAddressOrEns: 'adresse ETH ou ENS',
        Strings.invalidAddress: 'adresse invalide',

        /// Home(empty)
        Strings.noPOAP:
            'Vous ne semblez pas avoir de POAP pour l\'instant. Mais il n\'est pas trop tard ! Vous pouvez découvrir les POAPs en créeant votre premier POAP.',

        /// Home(available)
        Strings.events: 'Évènements',
        Strings.poaps: 'POAPs',
        Strings.growth: 'croissance',
        Strings.monthly: 'par mois',
        Strings.filterHint: 'Filtrez par nom, description, lieu, etc.',
        // --- Prefs
        Strings.visibility: 'Visibilité',
        Strings.hideDuplicates: 'Masquer les doublons',
        Strings.showAll: 'Montrer tout',
        Strings.sort: 'Trier',
        Strings.newest: 'Plus récent',
        Strings.oldest: 'Plus ancien',
        Strings.shape: 'Forme',
        Strings.square: 'Carré',
        Strings.round: 'Rond',
        Strings.layout: 'Disposition',
        Strings.grid: 'Grille',
        Strings.list: 'Liste',
        Strings.timeline: 'Timeline',
        // --- Filter
        Strings.filter: 'Filtre',
        Strings.filterTitle: 'Titre',
        Strings.filterDescription: 'Description',
        Strings.filterCountry: 'Pays',
        Strings.filterTag: 'Tag',
        Strings.filterChain: 'Blockchain',
        Strings.filterClearAll: 'Effacer TOUT',

        /// Home(edit mode)
        Strings.editMode: 'Éditer les POAPs',
        Strings.editTags: 'Editer les tags',
        Strings.newTag: 'Nouveau Tag',
        Strings.newTagHint: 'nouveau tag d\'évènement',

        /// Moments
        Strings.momentsDesc: '''Votre collection de POAPs est votre identité numérique.
            Elle montre au monde qui vous êtes : où vous êtes allé, ce que vous avez accompli et qui vous avez rencontré.
            Moments est un moyen d'ajouter de la valeur à votre souvenir numérique en sauvegardant des instants de vie dans un POAP, pour toujours.''',
        Strings.uploadMoments: 'Publier des moments sur welook.io',

        /// GitPOAP
        Strings.gitPOAPDesc:
            '''Un GitPOAP est un POAP ordinaire (avec un petit extra) qui est frappé par la plateforme GitPOAP pour les contributions significatives apportées aux projets open source. 
            Les propriétaires de repos distribuent automatiquement des GitPOAPs à leurs contributeurs en reconnaissance du travail accompli.''',           
        Strings.gitPOAPStart: 'Contribuer à POAPin',

        /// Watchlist(Initial state)
        Strings.watchlistHint:
            'Vous pouvez ajouter ici les adresses qui vous intéressent.',
        Strings.addCollection: 'Ajoutez votre première collection',

        /// Watchlist(available)
        Strings.follow: 'Suivre',
        Strings.unfollow: 'Ne plus suivre',

        /// Me
        Strings.connectWalletHint: 'Connexion via navigateur & wallet.',

        /// Profile
        Strings.profile: 'Profil',
        Strings.dangerZone: 'Zone dangereuse',
        Strings.deleteAccount: 'Supprimer le compte',
        Strings.deleteAccountDesc:
            'Êtes-vous certain de vouloir supprimer votre compte ?\n\nCette opération ne peut être annulée.',
        Strings.deleteAccountConfirm: 'Supprimer',

        /// Tags
        Strings.tags: 'Tags',
        Strings.manageTags: 'Gérez vos tags',
        Strings.noTags: 'Aucun tag pour l\'instant',
        Strings.addTag: 'Nouveau Tag',
        Strings.editTagHint: 'Choisissez ci-dessus\nou',

        /// Settings
        Strings.settings: 'Réglages',
        Strings.settingsDesc: 'Notifications, données, etc.',
        Strings.general: 'Général',
        Strings.language: 'Langue',
        Strings.contributeLanguage: '🙇 Contribuer à d\'autres traductions 🔗',
        Strings.data: 'Général',
        Strings.cache: 'Effacer les données en cache',
        Strings.cacheDesc: 'À utiliser en cas de problème avec l\'application.',
        Strings.about: 'À propos',

        /// Account
        Strings.signIn: 'Connexion',
        Strings.logOut: 'Se déconnecter',
        Strings.signinApple: 'Se connecter avec Apple',
        Strings.signinGoogle: 'Continuer avec Google',
        Strings.tos:
            'En continuant, vous acceptez nos conditions de service et notre politique de confidentialité.',

        /// Common
        Strings.done: 'Effectué',
        Strings.alert: 'Alerte',
        Strings.error: 'Erreur',
        Strings.learnMore: 'en savoir plus',
        // --- Months
        Strings.january: 'Janvier',
        Strings.february: 'Février',
        Strings.march: 'Mars',
        Strings.april: 'Avril',
        Strings.may: 'Mai',
        Strings.june: 'Juin',
        Strings.july: 'Juillet',
        Strings.august: 'Août',
        Strings.september: 'Septembre',
        Strings.october: 'Octobre',
        Strings.november: 'Novembre',
        Strings.december: 'Décembre',
      };
}
