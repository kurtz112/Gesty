// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-27
// ---------------------------------------------------------------------------
unit GestyTools.Sql.Icone;

// Icone della barra comandi della pagina Aggiornamento DB: PNG 32x32 della
// libreria di immagini DevExpress (D:\AI\SRC\_Immagini\dxImages\png), incluse
// nel codice in Base64 e caricate all'avvio nella lista di immagini. Non sono
// SVG come quelle di zFbScript. Nel codice e non in un .res: il progetto non
// ha bisogno di un file risorse in piu' da compilare e da ricordare.

interface

uses
  cxGraphics,
  dxGDIPlusClasses;

type
  // Indice di ogni icona nella lista riempita da CaricaIconeSql
  TIconaSql = (isNuovo, isApri, isSalva, isSalvaConNome, isEsegui, isInterrompi, isCopia);

// Svuota la lista (32x32 a 96 DPI, DevExpress la scala da solo) e vi mette le
// icone nell'ordine di TIconaSql.
procedure CaricaIconeSql(Lista: TcxImageList);

// Lucchetto del pulsante "Blocca avvio di Gesty", presente su tutte le pagine:
// va nei glifi del pulsante e non in una lista, perche' le barre delle pagine
// e quella della pagina Aggiornamento DB hanno liste di immagini diverse
procedure CaricaIconaBlocco(Glifo, GlifoGrande: TdxSmartImage);

implementation

uses
  System.SysUtils,
  System.Classes,
  System.NetEncoding,
  Vcl.Graphics;

const
  // RichEdit\ProtectDocument_16x16.png
  IconaBlocco16 =
    'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAH3RFWHRUaXRsZQBQcm90ZWN0RG9jdW1lbnQ7U2VjdXJpdHk7nIOmoQAA'
    + 'AkNJREFUeF6Fkk1IVVsUx39bbpI5KGkUQVDQKCkowj4sntTg3YokkD4IHkHviWhgGakIgqOkL4THhaIGQaRCVKSDBg8bmIKIRYhiVAQ1'
    + 'aBCRlnE/uuestR7scw8HHdQfFntzWHut3/mv5QDXMzDzDOfqzBRTUDPMwPypqEb3ICiM9TXtPWhmRUpKAc6wup6T1fxObben9pXeLC2g'
    + 'ilfn3UkSOVxZ6XRwoX4rEiX6r8sKKABdJ3ZgRPjJrxiK+buIArjlBVA1AHofvCSW+c6+u49zR6rjPFd7vAMJhYnH1yMCMQWgvWG7J/BA'
    + 'ZohHwROYGiKCzw+VUDTxoITGtUeviIWLCNavraQipcy8mGJu+i07688PhiL/qOinxAOxyOVj2+LxeVwj8qE308+mjRto+vsUD4dG0g+H'
    + '/utX0T9igrLYxL4nMyQEsK5qJVUVjunZNzQcPchfjR10dzYz+GB49+zI7UrnMgUHrGrJTGQzLbv4/K3gO8aLk81lyT1tZcX8HBIIoQhS'
    + 'VG/g91wwmb758UBpjALAv8OzSwhWlwuHvs5R3TKASR7CAoQ5LMgyerW1BihPAfGC0Hx4Szx3TGF+YZ7wtUCYx6Yvc//OGKfP1GAaegrA'
    + 'pQAp5LLPz94Y3R8ZVzLQ4GdukXYJfXeTkPdfCv4xKoRBMsbiva70n0B5aU1dEqy5eGnzO4IcJkJ32x7QEFNBgxDAUmamQN7HMjnn8gs/'
    + 'gvHRK421EggSKCKKirCYl3GgmOLXKqRvfYjpHIkMKAKF/wEcsWqWxQxBSwAAAABJRU5ErkJggg==';
  // RichEdit\ProtectDocument_32x32.png
  IconaBlocco32 =
    'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAH3RFWHRUaXRsZQBQcm90ZWN0RG9jdW1lbnQ7U2VjdXJpdHk7nIOmoQAA'
    + 'BhhJREFUeF6tln9sleUVxz/Pe29vW7hlqzTbKsN2DCtixBkS0XUJgumouh9micNkc8uqzC0jmUvmFrZk/2xL5l/ExWQs6ELcsjh1BiNT'
    + 'VgwUIeDPRVxBClJaQaCW2dL7673v+z7nrLRP7vu26+UGstOcnPM8vbnnnO/3nPNco6o4wRgDYBJKDT++q/4/BSwQAhGgyZhp/lfMb/7W'
    + '/wqYNQqIKKCoKIKielGJzwKiAok7mfKl8tkwCPb/4eHV3YC4ZKom4Kowa375zeX8v2Tj4we+BNQBZWKpigCKAlDwLbVEARRnFXFWpw3j'
    + 'OR8HeAowzBJvLgpEtEqo2NNkcFVAE2diqhyNcfDaCBhUScpf9g6jKCqOfwQR9+UqiGglqOj05zas60DjvwS9tROYHZ9vr25LYuAgNgl/'
    + 'ZsUa3zlELhMBmZXBU3tOoqoVOBWtVC1TgafOsa/KQ93LABBAlMtLQJkp31nzuSTfSTRc5UlfEXBoKDoHAsaYS44hsxHYtvsEIriKxVmd'
    + 'NfeKFVtB4wd3LkNUESuoCIB3RU2oCt9ds6SCgFApD3eFqLpgltBa1FpKvo+i+OUQayM3hni1E0gi4KL+6ZUTCDjedSbvImQbU7RkM0Tl'
    + 'Au8cPsboR+cp5CYm79N8uqUZv5gFqHfxPEAuiUCSZ8XwvTs+j6KgBkGTAGGtxS+V+efBft7sH+SOVddx/ZJOmuY3MHJ+jH+/N8ip/W/R'
    + '+ZWeh9/e89xv/cJEAIS4EudOQGYunyd2vY+qYIXEBCgeyuKWRo4cPY6RiE0b7mbvwUM8vu15zo6c56pPNrG0fRHrv7qWf+yq/5Fl/YLX'
    + 'dmzd6GqLaiPgqO7pWgqiKPGc24tqLQODZ+ibrHTTA938/qmX0aDIN9Z1cs2iT3Fy+Bwv7TnA8RPD3HbLTXxwZvT+6794z/PvHdjeC9i5'
    + 'EDDJPSAO9q29x+I5d2pFaWtp4FD/AF23LqP31bewfoEf99xDJlMPeCxfNp+2xa1s+fPfGRr6kGuXfJaRkY96gD1AUIUCN7fx3E8j4NBQ'
    + 'UdSAjSxBUKZv/+us6FjFpt/1svH+u0mlUhhjUFWM55FKp1nbuZIn/7qD1ZP21dcyq4AMUAJsFQpIUsDWnceQZPdbZeXSZgK/TL5QpGl+'
    + 'IyOjYyxszuL7AZgQEUFE8YMyC+bPI5fPk520Vr1moAEoANHcq1gEiDfZg1/uqPjKdAJhGOCffoObvdd55tFe7m1XPrH7W44qMBaMQqNA'
    + 'vUB3ayvjB7by9faU13Pftbc/8vTxF4FgbgSY2YR/3DkQb74p/i03ty/gpqOP8pONv6bh6i+AKiCg4qCTxFm4wZ0nhg6ljjz9q83ALqA4'
    + '5ypWARIdv6G7I/HGK2EklEpF0u+O09C6Ah0fgDBHTUnV07RoKV6kC90Emku9hi4obHn5KKIav4SRZUVblpWFcZAIimdJyu6DR3ji2T4e'
    + 'vHc1a2+7gYqEeTAZ/PyFysTV2AOKAt9fd10FDdHpCSiWCoR9Y2hxBJ04iWlswQmPbXuJI6d9GvaeY+2tyyHKA6Cl80Sj/fgTHwOYqi9U'
    + 'kgKSz6q7EBXECiLTVdmh7cjwDmT0X2humPu6OvhM+3LW37kKvDQ6eW+HdqAnt0PhHCIGwFTbhK5uGM+Vp4MDIpVsiKKIQr5MkwU0wEul'
    + 'Mf5/0IuK4n18gdHTdZjSjegH+9AL72OMgXQdaIRYrZqAAlFQLvU99Nj+29VxrpUt6GiwlqBc4BdWQUNMKhN3MLBvoIi1Wd4ZnKDrmhSm'
    + 'LgMKGByC1REQoPzkI11fAzKJn9KeszhbBzT9/KfN7yIhJl1XocsA+w7nmHdVG28OjGHuakULp8AAajBYVKnShPErVQT8RFCSvkugLGIw'
    + 'EqJeHSYukUNbboGr78KkG9GohEnVYTCItaDqegCq9gBgnVYTC2SiSPNjx9/IZtML3Sga1ACqmMHtrmVc9gbw6hk99SGRUARCQNKzH6Fa'
    + 'YowjEoLDZ6MfBs9s3mygRSyIgBWQ6UIRMVhRVAzipigSk3v7TPAzoOQSuCIRoPzAs7kXgJ2OElNbAQhd8Lx7Da9Ykr3izbXSq9yJUwvo'
    + 'fwGpZ0sNbf7W+AAAAABJRU5ErkJggg==';

const
  // Actions\New_32x32.png
  IconaNuovo =
    'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAPXRFWHRUaXRsZQBOZXc7UGFnZTtCYXJzO1JpYmJvbjtTdGFuZGFy'
    + 'ZDtJdGVtO0JsYW5rO0RlZmF1bHQ7RW1wdHk7EwRS7QAABEtJREFUeF6NlsGLHFUQxn/1emc3SszBuxAENXoTUYlGwyKiBw/GYxBF'
    + 'xVNAEnIwGyOJ6xJzCYioJyXgSUQ9iIggXsQcVfwDBDX3YCDZnZnuV58w++iiH+vYdek3zWPq++r7qqpNEmZGCbvy5S8/WrJ1BDIw'
    + 'gQAkDEMIAQYIgUDlLhIAN27cfPf06+ubgAN6/8pVIUfAqVefoASSWCHCADOz9ZePPciYmM872ux0bWbWduzsdFy/scP2tH37vY++'
    + 't40Tz24C+eQrj/Pntev64rvfqWOFYZjKIWeB9VDBQDIozAG8XJYZwsgSV3/9ixMvHmZ7pz13/vK39s7p5zaB7uBdd7L1wQ/6XwBI'
    + '5ag+dzwFPQhITQKEmkROu+fZvAXg8EMHye5vnbn4tV06+8ICxLk3nnZARJBqAF4yCsNlSAaBCaE4S6SUSMmwxhDGbNoC0DSJIw/f'
    + 'zZFHDp09df7z88Ck5LMlEgRlSQCR2ykyMJQBFiDMDLmYzuYArCTDSBx97F46943Zmc/4+NJLm0BLMeeeEriIUKQSFrL0OANMMsMw'
    + 'ZrMWM1hpjJSMphHPHD2E57wxbz/lk8uvXQC0FwALAATTSAIqJUCAof7ibvLJWsOB/WucvPAVrmhREE8duY/7H7hnA9gC8n93gTuD'
    + 'IitAgAII6uV0d1Jj3LZvlePHHuXm9nRhxtyJLjttl2kM/vj7H4BmmQdC+wF7MCneEWUSYAZgrE0amgP7uGP/Gm12cpsXALoukwz8'
    + 't2t9pQGWesBFsJRwIhAIRQXKHTNYnTS4xEQNebUhLwaVs9KA40TyJRJE6QOEJDAI8kYPo6gSY8R2jZhSb69JY3jHUgDFhA4wSCg8'
    + 'WrHqCARenmGPkCdZQskXYNxHVMB9IDEqIg/LIlTPjkCLFFpJkMwWJtVYCQA0GEqxFdWDiFUpDSGpOkiQUsKzxpgwkgqqMg/TyAvv'
    + '8EmsalEBEq4CICRX7YGCUoM/K6AiAlwBZlRNU3nBkBjnAUkDCRwL1pW2Cm8ggjoCZDDcY2SnjyUSZATIhQxM6lmFqKCeKvHOtMdQ'
    + 'C0mlER7IWeVUtxj1bgj2ig6IphAqWqhI6nmMBBmAWCZQdYWF0eJ3ierDpfp+cGnEIPIcQyVMBRDJqr0QwFRN0AAllpgwvozrNgwg'
    + 'Fruw7oTwQyQchkpXib09YGYWk1AokoEsJLHIqmAMEDuh2p4EyHFtGBUwJFWlDKaiZhz9Htsj7OASGuOB7CqaOVH4kpxgW6/l0rOo'
    + 'uiCKGSXcGbOMCkPvZwlSPYbrFV0lNlHIEiqNW0bIHdDQ7ap7P2DgJY8U5GTIRKAqFSjklg0iLybkwO2T+sMEyQZAgnUAVUzOyF/0'
    + 'xwWQAe0FwIF2Otv+6c2L3zxpA/bq9a6rEXIrJqBX47jEdHrrZ2AGeA1A5eXOh1vHnwfWgCZ6torq3Yg7KsynwK1yVi2BgDnQlUtj'
    + 'Eo+PIOkhAfwLMvtztSWI1kEAAAAASUVORK5CYII=';
  // Actions\Open_32x32.png
  IconaApri =
    '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';
  // Save\Save_32x32.png
  IconaSalva =
    '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'
    + 'rkJggg==';
  // Save\SaveAs_32x32.png
  IconaSalvaConNome =
    'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAEnRFWHRUaXRsZQBTYXZlIEFzO1NhdmWVWej7AAAEzklEQVR4XrVW'
    + 'PahcVRD+zr13EzdpVSRo2ghWQoooFgbtrEQ7K0GwUUHEn6BikcJGDNgKKbWwNxYpUgUJiKCkFVFEjcTw8nZfdvfMfCPMGc551/vW'
    + '8FAPnD1nh30z3/2+b+a+ZGY47Eop1Ws9fU/XlrgBIAAb8O9WOv/J5csp4axntZLa/MM/4+7hcprBVK+cf+uZpwFwaE90+OJOBnD2'
    + '3VeewmHW+x9dehJA5wC20HU3RIwEPUPCO2ut7O5XNa6VhSNDAkkEgDSMi6OPxOluOkZsIBlFgt4EJCSn3qouqUmCBNJqzmF/8dfO'
    + 'X/xgmM3OwdAbgOvXrmHn5p948ORDOHPmUS9A0hOIKkSyx2BAwCh3o6dsbFhgKDQoOQHglPTDcO6J04/0qUvouw5XL32F48c3mM/v'
    + 'wfMvPBfGiiSqyHmDzz+7WuqyChClm/PM0siMphVA2s9AR2VPA376+QZy1upaGv1sAMxZoBJqHNHtZ2W+xIMiWCp3tSZBN3KWqqPb'
    + '3d2DeeJSWEQ8o2tMA+nAnAXSKtD6lNGKJEbfwfABeSCARCrEFEYFjDWRqoAOIDYZ2++hcysUO2IRKST8owcKpaJOK6X9oYiWYta2'
    + 'ksib7Kd5oakM/hApVYbqCFSbeMADVIVKAcFeAZpvFQEZgPy7Yr23wp07axjpcVYaAGspYTYKhAd4YBsmUYGED+jozU+RDBH1J845'
    + 'V6YkK5RWny7OySBKrROKTLpVAoWoQN0DWkQLEy52lkB1e9AOgmSjuHogRWVz63u55otgawogqQjUZVDX6d4H7seN334HuhXefuMd'
    + 'GEZGdGAnTj4M4lmYNR/AIQQTVftGC9k8MDVhVgex3mScfvwxIOYAyEKIhiyq2KzWAI61Nhwp3SRpjESnbOmCJFmwyYWFxWLZkpJQ'
    + 'A5JZbUd1T6wwmw0emx8dcNCy0UfaP4hs6gGRoF/r0CksEsY2TOhSCDbrFVbLm3jp1QvjNnQvsHbEMBtw+9Yt3HfiVHhqfQVABsAx'
    + 'AyKQnB1EtFwrGqOYiJNEXq0heVFMy6a/1d+V7/P5Mfzx6w/48osPTwG4DWAJYA3Axm2o6u2mwYBIDv2DBae/3FUF6BK62QCwb++K'
    + '8EOXALB874cZum4GALsBYHPgv2RUQZbsycsEFHx64U0Yx8YypDqqub/9XB4gSMOLL78HJDd79AUkNmNP21CyQMVVLlIQEI0pWIuh'
    + 'tV3QHOBi4NBPqqLrepCFvXGDGCYmdGeLgBQYCyMW6eMCVp1RNWeTO37b3pYJXTX1QasbmVAFumnvAxGtuo+KGOroZQuWOFFlUFWX'
    + 'iLTa+75jTSSgCLJsaheoSKUdzdkhx7jPDRFPEYzBZkN0Uxu/mAIIVBpdoHTKQoIEeulWbHw2OWDjuKoES9slmL6MsvgZXYCLX/+C'
    + 'W8sNGAOIBDTaS4kSp0Et7iHRbH68MODxBN4FgJX6qpKlV1WPiCqGo3Mc4cwL08yL94SP086Lx907Be31bASpcNiezwSARq0JAALI'
    + 'q9XywvXvv3vdgB4wDMOAb7/5ETu3VyEPXVdVQsoZkhXHUw1kiftaLrBY7LpbN5u9j9sAaiuZGVJKKcAcid28MVmHjjkxMXpXAPK2'
    + 'OSCBbl3b5b9bFrm51QNViv93TZz4Fwf8RrHBXWn5AAAAAElFTkSuQmCC';
  // Arrows\Play_32x32.png
  IconaEsegui =
    'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAABF0'
    + 'RVh0VGl0bGUAUGxheTtTdGFydDtdYUB6AAADN0lEQVR4Xu2Xa0yTZxTHBwgTIkb3Aa/fNF4Sh6DLqLiBQ1KBFqmhmzoMCiqDxbuE'
    + 'RZRJqBTLLAIi1qqUQkE76AWkA0msc1AuhYLVRZAJ1uIFDREvIVmW4H9npDEF2afeYuKb/D48OefJ+T3n5Eme9xMALmXKgAO/D1Pg'
    + 'o4Cb6NpG5ZmrrHmuEvAQNUSDeHG2jrWLvW2pu7MFPM/+xkbLgAzi33ejSMPWFtRELXKmgNeZq1F4/saIhyMdqNIfA61HC9SRqfv4'
    + 'QdOcIpCvjsTQawOMTy6hf1iDjocKiLXJOK2K7My9wgxwuIBQsQFPXrWj01w4zt2hSphHWqHu5IFi/5yqZp44ei5kusMEcn9lYvBl'
    + 'M/Tmggn0PKuG8XEdzl//EQI5s5dfER7iEIGcynAMDDei3XT6PboGxeh9pkStQQDKG8uWrS/OEIfOtKvAifIw3HokhW5AgJYHwimh'
    + 'OI2mHiXaveCVhZmzpN+w7CaQKVkHvakINbcT0dSfA11/7pS0PsiD8VEZNN1C/KLcjOMloZXpoq/9bBbIuBBCBU5BbvgOiu54aO8d'
    + 'R9N9wf/SbipGz1MViusTQXufk4C7TQJHRF/hRh8PlZ2xFrhQ3/4B2r4s3Pwr5x1/3D9JV/Q8jUMG6c0DoH1jqYXBEhLwsEkgrSgY'
    + 'jT3pkOk5E6jQb0JVVzzq7uwngZMwmCXQGPnU/i04mMf4k5uynE37Z9gscCifQUUOQtoWPRmS4NJYdkJ9KwWZciYVDnqdcDTgZx9f'
    + 'Tz+S9yamEW42CewXfglVdzIkLVETuNyxFcquJAhq2aCct0lZq1RrIhZ+bjm1p/XsbRLYI/gCcsMOXNRFgKCTc8bXohuxSCsNRUr2'
    + 'qj7O7iVcyp1FfGppuZvdrmEKfzVk7ZtxoXkDSltiUNbGRXr5OiRnrx79/vAK/mdzvOdSns/kdttNIIkXCImOQ8SAp1iPPYUMbE/3'
    + 'r2dELAikuO/kdttdYGdmAPIbw3FAvBY7jq00sRIWx1FgNjHdut0OE0jI8KfC/n9/u3dZnt9CnwXW7XbKiyjupxUNQRHzGbSYSXgR'
    + '7k59ExLe1u12+qvYcmK3jz8mjhJwJa4X+BeRTTk6iFgKpQAAAABJRU5ErkJggg==';
  // Arrows\Stop_32x32.png
  IconaInterrompi =
    'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAAt0'
    + 'RVh0VGl0bGUAU3RvcDu6bSBPAAABlElEQVR4Xu2WPU7kQBCFX3s8Hu8MIlgJSLgG6WZAgERGwA3gKJwADkBGhkTAj8gRKScAiYBN'
    + 'QDP22O6uKqolSGHa7RWsmCe98JM+u6pbnYoIvjKp9nsJzAWMMfhXEZH/bwRzAXN0vn1iDLYA5AhLJYKzvc3THQDSViBh5q2Ntf18'
    + 'IVuGMcmMy8aYNE/5xe2hF/cQtRYgknyY/sb98zVEGLPEi64u/oFnYwUMOQaDQOwwc+SNUVZjopbQOQZxA2ZCSDzjWZ9IAYKlCiSM'
    + 'kHjGs/ECllE0f+HIBi2hMp6NF7CWUdkXvEwfMMyWkCaDj4W5RqnCo2xF2Y5G0LipttI+oN/7pV3Q5kiMxwXMDpZrWJpop9B4prsR'
    + 'NK54PwUgHqOyY3wWZboaAaF2JSjwFCijbEdLWPuvYRcooExXO6ACLf5A0dEOOG47gm4uInJcl/Vk0O8NEBJl4NlYAakrurq5fFwH'
    + 'kCEsjbN8BUBiBPj44G4XwEjbQ1hIW2g5SkBbaiutQVhEy7ECoiXfn/MmFJGf9SqeC7wCvZ0U7XSbSF4AAAAASUVORK5CYII=';
  // Edit\Copy_32x32.png
  IconaCopia =
    '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'
    + 'AElFTkSuQmCC';

procedure AggiungiIcona(Lista: TcxImageList; const DatiBase64: string);
var
  Immagine: TdxSmartImage;
  Flusso: TBytesStream;
  Bitmap: TBitmap;
begin
  Immagine := TdxSmartImage.Create;
  Flusso := TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(DatiBase64));
  try
    Immagine.LoadFromStream(Flusso);
    Bitmap := Immagine.GetAsBitmap;
    try
      Lista.Add(Bitmap, nil);
    finally
      Bitmap.Free;
    end;
  finally
    Flusso.Free;
    Immagine.Free;
  end;
end;

procedure CaricaIconeSql(Lista: TcxImageList);
begin
  Lista.Clear;
  Lista.SourceDPI := 96;
  Lista.Width := 32;
  Lista.Height := 32;
  AggiungiIcona(Lista, IconaNuovo);
  AggiungiIcona(Lista, IconaApri);
  AggiungiIcona(Lista, IconaSalva);
  AggiungiIcona(Lista, IconaSalvaConNome);
  AggiungiIcona(Lista, IconaEsegui);
  AggiungiIcona(Lista, IconaInterrompi);
  AggiungiIcona(Lista, IconaCopia);
end;

procedure CaricaImmagine(Immagine: TdxSmartImage; const DatiBase64: string);
var
  Flusso: TBytesStream;
begin
  Flusso := TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(DatiBase64));
  try
    Immagine.LoadFromStream(Flusso);
  finally
    Flusso.Free;
  end;
end;

procedure CaricaIconaBlocco(Glifo, GlifoGrande: TdxSmartImage);
begin
  CaricaImmagine(Glifo, IconaBlocco16);
  CaricaImmagine(GlifoGrande, IconaBlocco32);
end;

end.
