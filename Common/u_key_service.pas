unit u_key_service;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, u_keys, LCLType, u_const, u_key_layer, character, LCLIntf,
  Graphics, u_gif, u_led_ind, Contnrs, u_text_line;

type
  { TKeyService }
  TKeyService = class
  private
    FConfigMode: integer;
    FKBLayers: TKBLayerList;
    FActiveLayer: TKBLayer;
    FActiveKbKey: TKBKey;
    FActiveGif: TGif;
    FLedMode: TLedMode;
    FLedModeFn: TLedMode;
    FEdgeMode: TLedMode;
    FEdgeModeFn: TLedMode;
    FLedColorMono: TColor;
    FLedColorMonoFn: TColor;
    FEdgeColorMono: TColor;
    FEdgeColorMonoFn: TColor;
    FLedColorReactive: TColor;
    FLedColorReactiveFn: TColor;
    FBaseLedColorReactive: TColor;
    FBaseLedColorReactiveFn: TColor;
    FLedColorRipple: TColor;
    FLedColorRippleFn: TColor;
    FBaseLedColorRipple: TColor;
    FBaseLedColorRippleFn: TColor;
    FLedColorFireball: TColor;
    FLedColorFireballFn: TColor;
    FBaseLedColorFireball: TColor;
    FBaseLedColorFireballFn: TColor;
    FLedColorStarlight: TColor;
    FLedColorStarlightFn: TColor;
    FBaseLedColorStarlight: TColor;
    FBaseLedColorStarlightFn: TColor;
    FLedColorRebound: TColor;
    FLedColorReboundFn: TColor;
    FEdgeColorRebound: TColor;
    FEdgeColorReboundFn: TColor;
    FBaseLedColorRebound: TColor;
    FBaseLedColorReboundFn: TColor;
    FBaseEdgeColorRebound: TColor;
    FBaseEdgeColorReboundFn: TColor;
    FLedColorLoop: TColor;
    FLedColorLoopFn: TColor;
    FEdgeColorLoop: TColor;
    FEdgeColorLoopFn: TColor;
    FBaseLedColorLoop: TColor;
    FBaseLedColorLoopFn: TColor;
    FBaseEdgeColorLoop: TColor;
    FBaseEdgeColorLoopFn: TColor;
    FLedColorRain: TColor;
    FLedColorRainFn: TColor;
    FBaseLedColorRain: TColor;
    FBaseLedColorRainFn: TColor;
    FLedSpeed: integer;
    FLedSpeedFn: integer;
    FEdgeSpeed: integer;
    FEdgeSpeedFn: integer;
    FLedDirection: integer;
    FLedDirectionFn: integer;
    FEdgeDirection: integer;
    FEdgeDirectionFn: integer;

    FCurrentKBLayout: string;

    //List of supported keys from programming guide
    FConfigKeys: TKeyList;
    FActiveModifiers: TKeyList;
    FBackupKey: TKBKey;
    FBackupMacro: TKeyList;
    FBackupMacroKey: TKBKey;
    FMacros: TObjectList;
    //FInvalidLines: TInvalidLines;
    FTextLines: TTextLines;

    //Gifs using programming
    FRainGif: TGif;
    FReactiveGif: TGif;
    FRippleGif: TGif;
    FFireballGif: TGif;
    FFireballLeftGif: TGif;
    FFireballRightGif: TGif;
    FLoopDownGif: TGif;
    FLoopUpGif: TGif;
    FLoopLeftGif: TGif;
    FLoopRightGif: TGif;
    FReboundHorGif: TGif;
    FReboundVerGif: TGif;
    FStarlightGif: TGif;
    FEdgeLoopLeftGif: TGif;
    FEdgeLoopRightGif: TGif;
    FEdgeReboundGif: TGif;

    //For Adv360 RGB leds
    FLedIndicators: TLedIndList;

    //List of supported keyboard layouts
    //FKeyboardLayouts: TKeyboardLayoutList;
    function CompareKey(key1: word; aKeyList: TKeyList): boolean;
    function CompareTriggers(aKeyList1: TKeyList; aKeyList2: TKeyList): boolean;
    function CheckUpDownKS(aKeyList: TKeyList): boolean;
    function CountMacroKeyStrokes(aMacro: TKeyList): integer;
    function GetBaseLayerAdv360: TKBLayer;
    function GetEdgeKey(key: word; layerIdx: integer): TKBKey;
    function GetFN1LayerAdv360: TKBLayer;
    function GetFN2LayerAdv360: TKBLayer;
    function GetFN3LayerAdv360: TKBLayer;
    function GetKeyLoadException(key: word; layerIdx: integer): TKey;
    function GetKeySaveException(key: word; layerIdx: integer): TKey;
    function GetKPLayerAdv360: TKBLayer;
    function GetLedDirectionFile(var sDirection: string): integer;
    function GetLedSpeedFile(var sSpeed: string): integer;
    function GetTextMacro(aKey: TKey; macro: TKeyList; layerPrefix: string
      ): string;
    function GetTopLayerRGB: TKBLayer;
    function GetBotLayerRGB: TKBLayer;
    function GetTopLayerTKO: TKBLayer;
    function GetBotLayerTKO: TKBLayer;
    function IsEdgeSyntax(value: string): boolean;
    function IsNumericKey(aKey: TKey): boolean;
    function IsAlphaKey(aKey: TKey): boolean;

    procedure FillModifiersFromValues(aKeyList: TKeyList; sModifiers: string);
    function GetKeyText(aKey: TKey; defaultValue: string = ''; checkAltGr: boolean = false): string;
    function IsAltGr(aKey: TKey): boolean;
    function GetTopLayerFSEdge: TKBLayer;
    function GetBotLayerFSEdge: TKBLayer;
    function GetTopLayerFSPro: TKBLayer;
    function GetBotLayerFSPro: TKBLayer;
    function GetQwertyTopLayerAdv2: TKBLayer;
    function GetQwertyBotLayerAdv2: TKBLayer;
    function GetDvorakTopLayerAdv2: TKBLayer;
    function GetDvorakBotLayerAdv2: TKBLayer;
    function GetOutputText(aKeyList: TKeyList; var aKeysPos: TKeysPos; keyIdxToFind: integer; var keyIdxPos: integer): string;
    function KeyPadException(value: string): boolean;
    function GetKeyPadException(value: string): integer;
    procedure InitGifsRGB;
    procedure InitGifsTKO;
    function GetLedMode: TLedMode;
    function ModifierExits(key: word): boolean;
    procedure ResetLedOptions;
    procedure ResetEdgeOptions;
    procedure SetLedMode(aLedMode: TLedMode);
    function GetLedSpeed: integer;
    procedure SetLedSpeed(aLedSpeed: integer);
    function GetLedDirection: integer;
    procedure SetLedDirection(aDirection: integer);
    procedure SetLedColorMono(aColor: TColor);
    function GetLedColorMono: TColor;
    function GetLedColorReactive: TColor;
    procedure SetLedColorReactive(aColor: TColor);
    function GetBaseLedColorReactive: TColor;
    procedure SetBaseLedColorReactive(aColor: TColor);
    function GetLedColorRipple: TColor;
    procedure SetLedColorRipple(aColor: TColor);
    function GetBaseLedColorRipple: TColor;
    procedure SetBaseLedColorRipple(aColor: TColor);
    function GetLedColorFireball: TColor;
    procedure SetLedColorFireball(aColor: TColor);
    function GetBaseLedColorFireball: TColor;
    procedure SetBaseLedColorFireball(aColor: TColor);
    function GetLedColorStarlight: TColor;
    procedure SetLedColorStarlight(aColor: TColor);
    function GetBaseLedColorStarlight: TColor;
    procedure SetBaseLedColorStarlight(aColor: TColor);
    function GetLedColorRebound: TColor;
    procedure SetLedColorRebound(aColor: TColor);
    function GetBaseLedColorRebound: TColor;
    procedure SetBaseLedColorRebound(aColor: TColor);
    function GetLedColorLoop: TColor;
    procedure SetLedColorLoop(aColor: TColor);
    function GetBaseLedColorLoop: TColor;
    procedure SetBaseLedColorLoop(aColor: TColor);
    function GetLedColorRain: TColor;
    procedure SetLedColorRain(aColor: TColor);
    function GetBaseLedColorRain: TColor;
    procedure SetBaseLedColorRain(aColor: TColor);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function FindKeyConfig(iKey: word): TKey; overload;
    function FindKeyConfig(sKey: string): TKey; overload;
    function GetKeyConfig(iKey: word): TKey;
    function GetCoTriggerText(macro: TKeyList): string;
    procedure AddModifier(key: word);
    procedure RemoveModifier(key: word);
    procedure ClearModifiers;
    function IsWinKeyDown: boolean;
    function AddKey(kbKey: TKBKey; iKey: word; modifiers: string; insertAtPos: integer): TKey;
    function RemoveKey(kbKey: TKBKey; index: integer): boolean;
    function GetModifierText: string;
    function BackupMacroKey(aKbKey: TKbKey): boolean;
    function BackupMacro(aMacro: TKeyList): boolean;
    function RestoreMacro(aMacro: TKeyList): boolean;
    function RestoreMacroKey(aKbKey: TKbKey): boolean;
    function BackupKbKey(aKbKey: TKbKey): boolean;
    function RestoreKbKey(aKbKey: TKbKey): boolean;
    function GetMacroText(aKeyList: TKeyList; var aKeysPos: TKeysPos): string;
    function GetKeyAtPosition(aKeyList: TKeyList; cursorPos: integer): integer;
    procedure ConvertFromTextFileFmtFS(aLayoutContent: TStringList);
    function ConvertToTextFileFmtFS: TStringList;
    procedure ConvertFromTextFileFmt(aLayoutContent: TStringList);
    function ConvertLedToTextFileFmt: TStringList;
    function ConvertLedToTextFileFmtAdv360: TStringList;
    function ConvertEdgeToTextFileFmt: TStringList;
    procedure ConvertLedFromTextFileFmt(aLedContent: TStringList);
    procedure ConvertLedFromTextFileFmtAdv360(aLedContent: TStringList);
    procedure ConvertEdgeFromTextFileFmt(aEdgeContent: TStringList);
    function ExtractEdgeFromTextFile(var aLedContent: TStringList): TStringList;
    function ConvertToTextFileFmt: TStringList;
    procedure ConvertFromTextFileFmtAdv2(aLayoutContent: TStringList);
    function ConvertToTextFileFmtAdv2: TStringList;
    function IsLedFile(aContent: TStringList): boolean;
    function IsLayoutFile(aContent: TStringList): boolean;
    function IsShiftDown(aKey: TKey): boolean;
    //procedure LoadKeyConfig;
    procedure LoadLayerList(layerType: integer = LAYER_QWERTY);
    //procedure LoadKeyboardLayouts;
    procedure UpdateCurrentKeyboardLayout;
    function GetReplacementKey(aKey: word; saving: boolean): string;
    procedure ResetLayout;
    procedure ResetLayer(aLayer: TKBLayer);
    procedure ResetKey(aLayer: TKBLayer; key: word);
    function GetLayer(layerIdx: integer): TKBLayer;
    procedure SetKBKey(aKBKey: TKBKey; key: word; overwriteTapHold: boolean);
    procedure SetTapAndHold(aKBKey: TKBKey; tapAction: integer;
      holdAction: integer; delay: integer);
    procedure ResetTapHold(aKBKey: TKBKey);
    procedure SetKBKeyIdx(aLayer: TKBLayer; index: integer; key: word; overwriteTapHold: boolean = true);
    procedure SetKeyMacroIdx(aLayer: TKBLayer; index: integer; aMacro: TKeyList;
      resetMacro: boolean = true);
    function GetKBKey(key: word; layerIdx: integer): TKBKey;
    function GetPositionKBKey(key: word; layerIdx: integer; isMacro: boolean = false): TKBKey;
    function GetKBKeyTrigger(key: word): TKBKey;
    function GetKbKeyByIndex(aLayer: TKBLayer; index: integer): TKBKey;
    function GetEdgeKeyByIndex(aLayer: TKBLayer; index: integer): TKBKey;
    function CopyMacro(aMacro: TKeyList): TKeyList;
    function GetSingleKeyText(aKey: TKey; var isLongKey: boolean): string;
    function ValidateMacros(aKey: TKbKey; var errorMsg: string; var errorMsgTitle: string): boolean;
    function ValidateMacros(aMacro: TKeyList; var errorMsg: string; var errorMsgTitle: string; var errorNumber: integer): boolean;
    function CountModifiers(modifiers: string): integer;
    function CountKeystrokes(aKeyList: TKeyList): integer;
    procedure LoadConfigKeys;
    function GetModifierValues(aKey: TKey): string;
    procedure SetAllKeyColor(keyColor: TColor; layerIdx: integer);
    procedure SetAllKeyColorEdge(keyColor: TColor; layerIdx: integer);
    procedure SetAllIndColor(indIdx: integer; keyColor: TColor);
    function GetKeyWithModifier(iKey: word; modifiers: string): TKey;
    function CountAllKeystrokes: integer;
    function AddMacro(key: word; layerIdx: integer): integer;
    function AddCopiedMacro(copiedMacro: TKeyList; key: word; layerIdx: integer): integer;
    function GetMacro(keyIdx: integer): TKeyList;
    procedure RemoveLastMacro;
    function AddKeyMacro(macro: TKeyList; iKey: word; modifiers: string; insertAtPos: integer; upDown: TKeyState = ksNone): TKey;
    procedure RemoveMacro(macro: TKeyList);
    procedure RemoveAllMacros;
    function RemoveKeyMacro(macro: TKeyList; index: integer): boolean;
    function GetMacroCount: integer;
    function RemoveDuplicateMacro(aMacro: TKeyList): boolean;
    function GetInvalidLinesText(layerIdx: integer = -1): string;
    function HasInvalidLines: boolean;

    property ConfigMode: integer read FConfigMode write FConfigMode;
    property ActiveKbKey: TKBKey read FActiveKbKey write FActiveKbKey;

    property ConfigKeys: TKeyList read FConfigKeys write FConfigKeys;
    property ActiveModifiers: TKeyList read FActiveModifiers write FActiveModifiers;
    property Macros: TObjectList read FMacros write FMacros;
    property TextLines: TTextLines read FTextLines write FTextLines;
    //property BackupKey: TKBKey read FBackupKey write FBackupKey;
    //property KeyboardLayouts: TKeyboardLayoutList read FKeyboardLayouts write FKeyboardLayouts;

    property ActiveLayer: TKBLayer read FActiveLayer write FActiveLayer;
    property ActiveGif: TGif read FActiveGif write FActiveGif;
    property KBLayers: TKBLayerList read FKBLayers write FKBLayers;
    property LedMode: TLedMode read GetLedMode write SetLedMode;
    property LedColorMono: TColor read GetLedColorMono write SetLedColorMono;
    property LedColorReactive: Tcolor read GetLedColorReactive write SetLedColorReactive;
    property BaseLedColorReactive: Tcolor read GetBaseLedColorReactive write SetBaseLedColorReactive;
    property LedColorRipple: Tcolor read GetLedColorRipple write SetLedColorRipple;
    property BaseLedColorRipple: Tcolor read GetBaseLedColorRipple write SetBaseLedColorRipple;
    property LedColorFireball: Tcolor read GetLedColorFireball write SetLedColorFireball;
    property BaseLedColorFireball: Tcolor read GetBaseLedColorFireball write SetBaseLedColorFireball;
    property LedColorStarlight: Tcolor read GetLedColorStarlight write SetLedColorStarlight;
    property BaseLedColorStarlight: Tcolor read GetBaseLedColorStarlight write SetBaseLedColorStarlight;
    property LedColorRebound: Tcolor read GetLedColorRebound write SetLedColorRebound;
    property BaseLedColorRebound: Tcolor read GetBaseLedColorRebound write SetBaseLedColorRebound;
    property LedColorLoop: Tcolor read GetLedColorLoop write SetLedColorLoop;
    property BaseLedColorLoop: Tcolor read GetBaseLedColorLoop write SetBaseLedColorLoop;
    property LedColorRain: Tcolor read GetLedColorRain write SetLedColorRain;
    property BaseLedColorRain: Tcolor read GetBaseLedColorRain write SetBaseLedColorRain;
    property LedSpeed: integer read GetLedSpeed write SetLedSpeed;
    property LedDirection: integer read GetLedDirection write SetLedDirection;
    property RainGif: TGif read FRainGif write FRainGif;
    property ReactiveGif: TGif read FReactiveGif write FReactiveGif;
    property RippleGif: TGif read FRippleGif write FRippleGif;
    property FireballGif: TGif read FFireballGif write FFireballGif;
    property FireballLeftGif: TGif read FFireballLeftGif write FFireballLeftGif;
    property FireballRightGif: TGif read FFireballRightGif write FFireballRightGif;
    property ReboundHorGif: TGif read FReboundHorGif write FReboundHorGif;
    property ReboundVerGif: TGif read FReboundVerGif write FReboundVerGif;
    property LoopDownGif: TGif read FLoopDownGif write FLoopDownGif;
    property LoopUpGif: TGif read FLoopUpGif write FLoopUpGif;
    property LoopLeftGif: TGif read FLoopLeftGif write FLoopLeftGif;
    property LoopRightGif: TGif read FLoopRightGif write FLoopRightGif;
    property StarlightGif: TGif read FStarlightGif write FStarlightGif;
    property EdgeLoopLeftGif: TGif read FEdgeLoopLeftGif write FEdgeLoopLeftGif;
    property EdgeLoopRightGif: TGif read FEdgeLoopRightGif write FEdgeLoopRightGif;
    property EdgeReboundGif: TGif read FEdgeReboundGif write FEdgeReboundGif;
    property LedIndicators: TLedIndList read FLedIndicators write FLedIndicators;
  end;

implementation

{ TKeyService }

constructor TKeyService.Create;
begin
  inherited Create;
  FConfigMode := CONFIG_LAYOUT;
  FKBLayers := TKBLayerList.Create;
  FActiveLayer := nil;
  FActiveGif := nil;
  FActiveKbKey := nil;
  FCurrentKBLayout := '';
  FConfigKeys := nil;
  FActiveModifiers := TKeyList.Create;
  FMacros := TObjectList.Create;
  FBackupKey := TKBKey.Create;
  FBackupMacro := TKeyList.Create;
  FBackupMacroKey := TKBKey.Create;
  LedIndicators := TLedIndList.Create(6);
  FTextLines := TTextLines.Create;
  //SetLength(FInvalidLines, 0);
  //KeyboardLayouts := TKeyboardLayoutList.Create;

  ResetLedOptions;
  ResetEdgeOptions;

  //LoadKeyConfig;
  //LoadKeyboardLayouts;
  UpdateCurrentKeyboardLayout;

  if (GApplication = APPL_RGB) then
    InitGifsRGB
  else if (GApplication = APPL_TKO) then
    InitGifsTKO;
end;

destructor TKeyService.Destroy;
begin
  FreeAndNil(FConfigKeys);
  FreeAndNil(FActiveModifiers);
  FreeAndNil(FKBLayers);
  FreeAndNil(FMacros);
  FreeAndNil(FBackupKey);
  FreeAndNil(FBackupMacro);
  FreeAndNil(FBackupMacroKey);
  FreeAndNil(FRainGif);
  FreeAndNil(FReactiveGif);
  FreeAndNil(FRippleGif);
  FreeAndNil(FFireballGif);
  if (FFireballLeftGif <> nil) then
     FreeAndNil(FFireballLeftGif);
  if (FFireballRightGif <> nil) then
     FreeAndNil(FFireballRightGif);
  FreeAndNil(FLoopDownGif);
  FreeAndNil(FLoopUpGif);
  FreeAndNil(FLoopRightGif);
  FreeAndNil(FLoopLeftGif);
  FreeAndNil(FReboundHorGif);
  FreeAndNil(FReboundVerGif);
  FreeAndNil(FstarlightGif);
  FreeAndNil(FLedIndicators);
  if (FEdgeLoopLeftGif <> nil) then
     FreeAndNil(FEdgeLoopLeftGif);
  if (FEdgeLoopRightGif <> nil) then
     FreeAndNil(FEdgeLoopRightGif);
  if (FEdgeReboundGif <> nil) then
     FreeAndNil(FEdgeReboundGif);
  FreeAndNil(FTextLines);
  //SetLength(FInvalidLines, 0);
  inherited Destroy;
end;

function TKeyService.GetTopLayerFSEdge: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := TOPLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-top';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SCROLL), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PAUSE), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 16));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 18));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 33));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 41));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 50));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK5), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK6), 52));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 66));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK7), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK8), 68));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 69, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 80, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 82));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK9), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK10), 84));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 85, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  //{$ifdef Win64}
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  //{$endif}
  //{$ifdef Darwin}
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCMD_MAC), 86, true, false));
  //{$endif}
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 87, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSPACE), 88));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSPACE), 89));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 90, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 91, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 92));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 93));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 94));

  result := aKBLayer;

end;

function TKeyService.GetBotLayerFSEdge: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := BOTLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-keypad';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_MUTE), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_DOWN), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_UP), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_PLAY_PAUSE), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_PREV_TRACK), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_NEXT_TRACK), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SCROLL), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_INSERT), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 16));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 18));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 33));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 41));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 50));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK5), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK6), 52));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 66));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK7), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK8), 68));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 69, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 80, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 82));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK9), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK10), 84));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 85, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  //{$ifdef Win64}
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  //{$endif}
  //{$ifdef Darwin}
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCMD_MAC), 86, true, false));
  //{$endif}
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 87, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSPACE), 88));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSPACE), 89));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 90, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 91, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 92));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 93));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 94));

  result := aKBLayer;
end;

function TKeyService.GetTopLayerRGB: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := TOPLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-top';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK0), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 1)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 14));
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SCROLL), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PAUSE), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 16));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 18));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 33));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 41));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 50));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK5), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK6), 52));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 66));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK7), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK8), 68));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 69, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 80, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 82));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK9), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK10), 84));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 85, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  //{$ifdef Win64}
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  //{$endif}
  //{$ifdef Darwin}
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCMD_MAC), 86, true, false));
  //{$endif}
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 87, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSPACE), 88));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSPACE), 89));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 90, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 91, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 92));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 93));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 94));

  result := aKBLayer;

end;

function TKeyService.GetBotLayerRGB: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := BOTLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-keypad';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK0), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_MUTE), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_DOWN), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_UP), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_PLAY_PAUSE), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_PREV_TRACK), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_NEXT_TRACK), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_INSERT), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SCROLL), 16));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 18));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 33));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 41));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 50));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK5), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK6), 52));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 66));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK7), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK8), 68));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 69, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 80, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 82));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK9), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK10), 84));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 85, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  //{$ifdef Win64}
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  //{$endif}
  //{$ifdef Darwin}
  //aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCMD_MAC), 86, true, false));
  //{$endif}
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 87, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSPACE), 88));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSPACE), 89));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 90, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 91, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 92));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 93));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 94));

  result := aKBLayer;
end;

function TKeyService.GetTopLayerTKO: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := TOPLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-top';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 13));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 16));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 27));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 40));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 41, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 50));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 52, true, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 53, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 54, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 55, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSPACE), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MSPACE), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSPACE), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 59, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_FN_SHIFT), 60, true, true));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SMARTSET), 61, false, false)); //SmartSet Key
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 62, true, false));

  //EDGE Key List Put Keys in order needed...
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L1), 0)); //First button
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L2), 1));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L3), 2));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L4), 3));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L5), 4));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L6), 5));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L7), 6));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L8), 7));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L9), 8));

  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B1), 9));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B2), 10));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B3), 11));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B4), 12));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B5), 13));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B6), 14));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B7), 15));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B8), 16));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B9), 17));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B10), 18));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B11), 19));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B12), 20));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B13), 21));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B14), 22));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B15), 23));

  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R1), 24));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R2), 25));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R3), 26));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R4), 27));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R5), 28));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R6), 29));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R7), 30));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R8), 31));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R9), 32));

  result := aKBLayer;
end;

function TKeyService.GetBotLayerTKO: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := BOTLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-keypad';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 0));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 13));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MOUSE_LEFT), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_PLAY_PAUSE), 16));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_PREV_TRACK), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_NEXT_TRACK), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LED), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_INSERT), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CALC), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PAUSE), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 27));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MOUSE_RIGHT), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_MUTE), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_DOWN), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_UP), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_APPS), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SCROLL), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 40));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 41, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 50));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 52, true, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 53, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 54, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 55, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSPACE), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MSPACE), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSPACE), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 59, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_FN_SHIFT), 60, true, true));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SMARTSET), 61, false, false)); //SmartSet Key
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 62, true, false));

  //EDGE Key List Put Keys in order needed...
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L1), 0)); //First button
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L2), 1));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L3), 2));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L4), 3));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L5), 4));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L6), 5));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L7), 6));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L8), 7));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_L9), 8));

  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B1), 9));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B2), 10));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B3), 11));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B4), 12));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B5), 13));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B6), 14));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B7), 15));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B8), 16));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B9), 17));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B10), 18));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B11), 19));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B12), 20));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B13), 21));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B14), 22));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_B15), 23));

  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R1), 24));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R2), 25));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R3), 26));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R4), 27));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R5), 28));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R6), 29));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R7), 30));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R8), 31));
  aKBLayer.EdgeKeyList.Add(TKBKey.Create(GetKeyConfig(VK_EDGE_R9), 32));

  result := aKBLayer;
end;

function TKeyService.GetTopLayerFSPro: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := TOPLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-top';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SCROLL), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PAUSE), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 16));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 18));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 33));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 41));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 50));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK5), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK6), 52));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 66));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK7), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK8), 68));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 69, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 80, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 82));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK9), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK10), 84));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 85, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 87, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSPACE), 88));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSPACE), 89));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 90, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 91, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 92));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 93));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 94));

  result := aKBLayer;

end;

function TKeyService.GetBotLayerFSPro: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := BOTLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-keypad';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_MUTE), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_DOWN), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_VOLUME_UP), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_PLAY_PAUSE), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_PREV_TRACK), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MEDIA_NEXT_TRACK), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMLOCK), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_INSERT), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 16));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 18));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD7), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD8), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD9), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MULTIPLY ), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 33));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 41));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD4), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD5), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD6), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SUBTRACT), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 50));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK5), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK6), 52));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD1), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD2), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD3), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ADD), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPADENTER), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 66));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK7), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK8), 68));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 69, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD0), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DECIMAL), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DIVIDE), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 80, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 82));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK9), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK10), 84));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 85, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 86, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 87, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSPACE), 88));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSPACE), 89));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 90, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 91, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 92));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 93));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 94));

  result := aKBLayer;
end;

function TKeyService.GetQwertyTopLayerAdv2: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := TOPLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-top';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SCROLL), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PAUSE), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KEYPAD), 16, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PROGRAM), 17, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 29));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 48, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 49, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 50, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 51, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 52));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 57));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 58, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SPACE), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 75, true, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_OEM_102), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 80));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 82));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 84));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 85));

  //For Pedals
  if (GMasterAppId = APPL_KINESIS_APP) then
  begin
    aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 86));
    aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_KPSHIFT), 87));
    aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPADENTER), 88));
  end
  else
  begin
    aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LPEDAL), 86));
    aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MPEDAL), 87));
    aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RPEDAL), 88));
  end;

  result := aKBLayer;
end;

function TKeyService.GetQwertyBotLayerAdv2: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := BOTLAYER_IDX;
  aKBLayer.LayerName := 'Qwerty-keypad';
  aKBLayer.LayerType := LAYER_QWERTY;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_MENU), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_PLAY), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_PREV), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_NEXT), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_CALC), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_KPSHIFT), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_MUTE), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_VOLDOWN), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_VOLUP), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KEYPAD), 16, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PROGRAM), 17, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_NUMLCK), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_EQUAL), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_DIVIDE), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_MULT), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 29));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_7), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_8), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_9), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_MIN), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 48, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 49, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 50, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 51, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 52));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_4), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_5), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_6), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_PLUS), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 57));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 58, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_0), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_1), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_2), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_3), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_ENTER1), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 75, true, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_INSERT), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 80));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 82));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_PERI), 84));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_ENTER2), 85));

  //For Pedals
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LPEDAL), 86));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MPEDAL), 87));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RPEDAL), 88));

  result := aKBLayer;
end;

function TKeyService.GetDvorakTopLayerAdv2: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := TOPLAYER_IDX;
  aKBLayer.LayerName := 'Dvorak-top';
  aKBLayer.LayerType := LAYER_DVORAK;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SNAPSHOT), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SCROLL), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PAUSE), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KEYPAD), 16, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PROGRAM), 17, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 29));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 48, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 49, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 50, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 51, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 52));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 57));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 58, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SPACE), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 75, true, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_OEM_102), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 80));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 82));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 84));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 85));

  //For Pedals
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LPEDAL), 86));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MPEDAL), 87));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RPEDAL), 88));

  result := aKBLayer;
end;

function TKeyService.GetDvorakBotLayerAdv2: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := BOTLAYER_IDX;
  aKBLayer.LayerName := 'Dvorak-keypad';
  aKBLayer.LayerType := LAYER_DVORAK;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 0)); //First button
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LWIN), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RMENU), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_MENU), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_PLAY), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_PREV), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_NEXT), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_CALC), 7));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_KPSHIFT), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_MUTE), 13));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_VOLDOWN), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_VOLUP), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KEYPAD), 16, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PROGRAM), 17, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_NUMLCK), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_EQUAL), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_DIVIDE), 27));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_MULT), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 29));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_7), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_8), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_9), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_MIN), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 48, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 49, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 50, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 51, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 52));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_4), 53));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_5), 54));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_6), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_PLUS), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 57));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 58, true, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 63));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 67));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_0), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_1), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_2), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_3), 73));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_ENTER1), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 75, true, false));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 76));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_INSERT), 77));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 78));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 79));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 80));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 81));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 82));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 83));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_PERI), 84));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_ENTER2), 85));

  //For Pedals
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LPEDAL), 86));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MPEDAL), 87));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RPEDAL), 88));
  result := aKBLayer;

end;

function TKeyService.GetBaseLayerAdv360: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := LAYER_BASE_360;
  aKBLayer.LayerName := 'Base';
  aKBLayer.LayerType := LAYER_BASE_360;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 0));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_LAYER_TOGGLE), 6, true, true, GetKeyConfig(VK_KEYPAD_TOGGLE)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SMARTSET), 7, false, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_7), 9));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_8), 10));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_9), 11));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_0), 12));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 13));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 16));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 27));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 50));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 52));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 53));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_FN1_LAYER_SHIFT), 54, true, true, GetKeyConfig(VK_LFN_LAYER_SHIFT)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_FN1_LAYER_SHIFT), 63, true, true, GetKeyConfig(VK_RFN_LAYER_SHIFT)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 67));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SPACE), 73));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NULL), 76, true, true, GetKeyConfig(VK_PEDAL)));

  result := aKBLayer;
end;

function TKeyService.GetKPLayerAdv360: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := LAYER_KEYPAD_360;
  aKBLayer.LayerName := 'Keypad';
  aKBLayer.LayerType := LAYER_KEYPAD_360;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_EQUAL), 0));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_1), 1));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_2), 2));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_3), 3));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_4), 4));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_5), 5));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BASE_LAYER_TOGGLE), 6));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SMARTSET), 7, false, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_6), 8));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMLOCK), 9, true, true, GetKeyConfig(VK_7)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_EQUAL), 10, true, true, GetKeyConfig(VK_8)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DIVIDE), 11, true, true, GetKeyConfig(VK_9)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_MULTIPLY), 12, true, true, GetKeyConfig(VK_0)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_MINUS), 13));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 16));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD7), 23, true, true, GetKeyConfig(VK_U)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD8), 24, true, true, GetKeyConfig(VK_I)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD9), 25, true, true, GetKeyConfig(VK_O)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SUBTRACT), 26, true, true, GetKeyConfig(VK_P)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 27));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD4), 37, true, true, GetKeyConfig(VK_J)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD5), 38, true, true, GetKeyConfig(VK_K)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD6), 39, true, true, GetKeyConfig(VK_L)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ADD), 40, true, true, GetKeyConfig(VK_LCL_SEMI_COMMA)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD1), 49, true, true, GetKeyConfig(VK_M)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD2), 50, true, true, GetKeyConfig(VK_LCL_COMMA)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD3), 51, true, true, GetKeyConfig(VK_LCL_POINT)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPADENTER), 52, true, true, GetKeyConfig(VK_LCL_SLASH)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 53));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_FN1_LAYER_SHIFT), 54, true, true, GetKeyConfig(VK_LFN_LAYER_SHIFT)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DECIMAL), 61, true, true, GetKeyConfig(VK_LCL_OPEN_BRACKET)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_FN1_LAYER_SHIFT), 63, true, true, GetKeyConfig(VK_RFN_LAYER_SHIFT)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 67));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NUMPAD0), 73, true, true, GetKeyConfig(VK_SPACE)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NULL), 76, true, true, GetKeyConfig(VK_PEDAL)));

  result := aKBLayer;
end;

function TKeyService.GetFN1LayerAdv360: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := LAYER_FN1_360;
  aKBLayer.LayerName := 'Fn1';
  aKBLayer.LayerType := LAYER_FN1_360;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 0, true, true, GetKeyConfig(VK_LCL_EQUAL)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 1, true, true, GetKeyConfig(VK_1)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 2, true, true, GetKeyConfig(VK_2)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 3, true, true, GetKeyConfig(VK_3)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 4, true, true, GetKeyConfig(VK_4)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 5, true, true, GetKeyConfig(VK_5)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_LAYER_TOGGLE), 6, true, true, GetKeyConfig(VK_KEYPAD_TOGGLE)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SMARTSET), 7, false, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 8, true, true, GetKeyConfig(VK_6)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 9, true, true, GetKeyConfig(VK_7)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 10, true, true, GetKeyConfig(VK_8)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 11, true, true, GetKeyConfig(VK_9)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 12, true, true, GetKeyConfig(VK_0)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 13, true, true, GetKeyConfig(VK_LCL_MINUS)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 16));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 27));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 50));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 52));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 53));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BASE_LAYER_SHIFT), 54, true, true, GetKeyConfig(VK_LFN_LAYER_SHIFT)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BASE_LAYER_SHIFT), 63, true, true, GetKeyConfig(VK_RFN_LAYER_SHIFT)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 67));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SPACE), 73));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NULL), 76, true, true, GetKeyConfig(VK_PEDAL)));

  result := aKBLayer;
end;

function TKeyService.GetFN2LayerAdv360: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := LAYER_FN2_360;
  aKBLayer.LayerName := 'Fn2';
  aKBLayer.LayerType := LAYER_FN2_360;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 0, true, true, GetKeyConfig(VK_LCL_EQUAL)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 1, true, true, GetKeyConfig(VK_1)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 2, true, true, GetKeyConfig(VK_2)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 3, true, true, GetKeyConfig(VK_3)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 4, true, true, GetKeyConfig(VK_4)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 5, true, true, GetKeyConfig(VK_5)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_LAYER_TOGGLE), 6, true, true, GetKeyConfig(VK_KEYPAD_TOGGLE)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SMARTSET), 7, false, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 8, true, true, GetKeyConfig(VK_6)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 9, true, true, GetKeyConfig(VK_7)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 10, true, true, GetKeyConfig(VK_8)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 11, true, true, GetKeyConfig(VK_9)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 12, true, true, GetKeyConfig(VK_0)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 13, true, true, GetKeyConfig(VK_LCL_MINUS)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 16));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 27));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 50));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 52));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 53));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BASE_LAYER_SHIFT), 54, true, true, GetKeyConfig(VK_LFN_LAYER_SHIFT)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BASE_LAYER_SHIFT), 63, true, true, GetKeyConfig(VK_RFN_LAYER_SHIFT)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 67));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SPACE), 73));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NULL), 76, true, true, GetKeyConfig(VK_PEDAL)));

  result := aKBLayer;
end;

function TKeyService.GetFN3LayerAdv360: TKBLayer;
var
  aKBLayer: TKBLayer;
begin
  aKBLayer := TKBLayer.Create;
  aKBLayer.LayerIndex := LAYER_FN3_360;
  aKBLayer.LayerName := 'Fn3';
  aKBLayer.LayerType := LAYER_FN3_360;

  //Put Keys in order needed...
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F1), 0, true, true, GetKeyConfig(VK_LCL_EQUAL)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F2), 1, true, true, GetKeyConfig(VK_1)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F3), 2, true, true, GetKeyConfig(VK_2)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F4), 3, true, true, GetKeyConfig(VK_3)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F5), 4, true, true, GetKeyConfig(VK_4)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F6), 5, true, true, GetKeyConfig(VK_5)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_KP_LAYER_TOGGLE), 6, true, true, GetKeyConfig(VK_KEYPAD_TOGGLE)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SMARTSET), 7, false, false));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F7), 8, true, true, GetKeyConfig(VK_6)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F8), 9, true, true, GetKeyConfig(VK_7)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F9), 10, true, true, GetKeyConfig(VK_8)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F10), 11, true, true, GetKeyConfig(VK_9)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F11), 12, true, true, GetKeyConfig(VK_0)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F12), 13, true, true, GetKeyConfig(VK_LCL_MINUS)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_TAB), 14));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Q), 15));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_W), 16));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_E), 17));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_R), 18));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_T), 19));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK1), 20));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK3), 21));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Y), 22));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_U), 23));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_I), 24));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_O), 25));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_P), 26));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_BACKSLASH), 27));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_ESCAPE), 28));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_A), 29));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_S), 30));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_D), 31));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_F), 32));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_G), 33));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK2), 34));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HK4), 35));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_H), 36));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_J), 37));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_K), 38));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_L), 39));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SEMI_COMMA), 40));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_QUOTE), 41));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LSHIFT), 42));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_Z), 43));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_X), 44));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_C), 45));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_V), 46));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_B), 47));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_N), 48));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_M), 49));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_COMMA), 50));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_POINT), 51));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_SLASH), 52));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RSHIFT), 53));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BASE_LAYER_SHIFT), 54, true, true, GetKeyConfig(VK_LFN_LAYER_SHIFT)));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_TILDE), 55));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_CAPITAL), 56));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LEFT), 57));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RIGHT), 58));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_UP), 59));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DOWN), 60));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_OPEN_BRACKET), 61));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCL_CLOSE_BRACKET), 62));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BASE_LAYER_SHIFT), 63, true, true, GetKeyConfig(VK_RFN_LAYER_SHIFT)));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LCONTROL), 64));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_LMENU), 65));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RWIN), 66));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RCONTROL), 67));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_BACK), 68));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_DELETE), 69));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_HOME), 70));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_PRIOR), 71));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_RETURN), 72));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_SPACE), 73));

  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_END), 74));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NEXT), 75));
  aKBLayer.KBKeyList.Add(TKBKey.Create(GetKeyConfig(VK_NULL), 76, true, true, GetKeyConfig(VK_PEDAL)));

  result := aKBLayer;
end;

procedure TKeyService.LoadLayerList(layerType: integer);
begin
  FKBLayers.Clear;
  if (GApplication = APPL_ADV2) then
  begin
    if (layerType = LAYER_QWERTY) then
    begin
      FKBLayers.Add(GetQwertyTopLayerAdv2);
      FKBLayers.Add(GetQwertyBotLayerAdv2);
    end
    else if (layerType = LAYER_DVORAK) then
    begin
      FKBLayers.Add(GetDvorakTopLayerAdv2);
      FKBLayers.Add(GetDvorakBotLayerAdv2);
    end;
  end
  else if (GApplication = APPL_FSPRO) then
  begin
    FKBLayers.Add(GetTopLayerFSPro);
    FKBLayers.Add(GetBotLayerFSPro);
  end
  else if (GApplication = APPL_FSEDGE) then
  begin
    FKBLayers.Add(GetTopLayerFSEdge);
    FKBLayers.Add(GetBotLayerFSEdge);
  end
  else if (GApplication = APPL_RGB) then
  begin
    FKBLayers.Add(GetTopLayerRGB);
    FKBLayers.Add(GetBotLayerRGB);
  end
  else  if (GApplication = APPL_TKO) then
  begin
    FKBLayers.Add(GetTopLayerTKO);
    FKBLayers.Add(GetBotLayerTKO);
  end
  ELSE IF (GApplication = APPL_ADV360) then
  begin
    FKBLayers.Add(GetBaseLayerAdv360);
    FKBLayers.Add(GetKPLayerAdv360);
    FKBLayers.Add(GetFN1LayerAdv360);
    FKBLayers.Add(GetFN2LayerAdv360);
    FKBLayers.Add(GetFN3LayerAdv360);
  end;
end;

procedure TKeyService.UpdateCurrentKeyboardLayout;
begin
  FCurrentKBLayout := GetCurrentKeyoardLayout;
end;

//Checks if key is numeric (ascii 48 to 57)
function TKeyService.IsNumericKey(aKey: TKey): boolean;
begin
  Result := (aKey.Key >= VK_0) and (aKey.Key <= VK_9);
end;

//Checks if key is alphabetic (ascii lowercase 65 to 90 or uppercase 97 to 122)
function TKeyService.IsAlphaKey(aKey: TKey): boolean;
begin
  Result := (aKey.Key >= VK_A) and (aKey.Key <= VK_Z);
end;

//Takes a list of modifiers in string and fills a list of keys with the values
procedure TKeyService.FillModifiersFromValues(aKeyList: TKeyList;
  sModifiers: string);
begin
  if sModifiers <> '' then
  begin
    if Pos(SHIFT_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_SHIFT).CopyKey);
    if Pos(L_SHIFT_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_LSHIFT).CopyKey);
    if Pos(R_SHIFT_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_RSHIFT).CopyKey);
    if Pos(CTRL_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_CONTROL).CopyKey);
    if Pos(L_CTRL_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_LCONTROL).CopyKey);
    if Pos(R_CTRL_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_RCONTROL).CopyKey);
    if Pos(ALT_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_MENU).CopyKey);
    if Pos(L_ALT_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_LMENU).CopyKey);
    if Pos(R_ALT_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_RMENU).CopyKey);
    if Pos(WIN_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_LWIN).CopyKey);
    if Pos(L_WIN_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_LWIN).CopyKey);
    if Pos(R_WIN_MOD, string(sModifiers)) <> 0 then
      aKeyList.Add(FindKeyConfig(VK_RWIN).CopyKey);
  end;
end;

function TKeyService.GetKeyText(aKey: TKey; defaultValue: string;
  checkAltGr: boolean): string;
begin
{$ifdef Win64}
  if (aKey.ConvertToUnicode) then
    result := KeyToUnicode(aKey.Key, (IsShiftDown(aKey)) and (aKey.ShowShiftedValue), checkAltGr)
  else if (defaultValue <> '') then
    result := defaultValue
  else
    result := aKey.Value;
{$endif}
{$ifdef Darwin}
if (IsShiftDown(aKey) and (aKey.ShowShiftedValue)) then
  result := aKey.ShiftedValue
else if (defaultValue <> '') then
  result := defaultValue
else
  result := aKey.Value;
{$endif}
{$ifdef Linux}
if (IsShiftDown(aKey) and (aKey.ShowShiftedValue)) then
  result := aKey.ShiftedValue
else if (defaultValue <> '') then
  result := defaultValue
else
  result := aKey.Value;
{$endif}
if (aKey.UpDown = ksUp) then
  result := '+' + result
else if (aKey.UpDown = ksDown) then
  result := '-' + result;
end;

//Checks if AltGr pressed (Ctrl + Alt)
function TKeyService.IsAltGr(aKey: TKey): boolean;
begin
  if (Pos(CTRL_MOD, aKey.Modifiers) <> 0) and
    (Pos(ALT_MOD, aKey.Modifiers) <> 0) and
    (Length(aKey.Modifiers) = 3) then
    result := true
  else
    result := false;
end;

//Internal function to get output text
function TKeyService.GetOutputText(aKeyList: TKeyList;
  var aKeysPos: TKeysPos; keyIdxToFind: integer; var keyIdxPos: integer
  ): string;
var
  i: integer;
  aKey: TKey;
  keyCount: integer;
  initLength: integer;
  mustAddKeyPos: boolean;

  procedure AddKeyPos(iStart, iEnd: integer);
  begin
    SetLength(aKeysPos, Length(aKeysPos) + 1);
    aKeysPos[Length(aKeysPos) - 1].iStart := iStart;
    aKeysPos[Length(aKeysPos) - 1].iEnd := iEnd;
  end;

  function GetKeyIdxPos(keyPos: integer; text: string): boolean;
  begin
    result := false;
    if (keyIdxToFind >= 0) and (keyIdxPos = -1) and (LengthUTF8(text) >= keyIdxToFind) then
    begin
      keyIdxPos := keyPos;
      result := true;
    end;
  end;

begin
  Result := '';
  aKeysPos := nil;
  keyIdxPos := -1;

  if aKeyList <> nil then
  begin
    keyCount := aKeyList.Count - 1;
    for i := 0 to keyCount do
    begin
      aKey := aKeyList.Items[i];
      initLength := LengthUTF8(Result);

      Result := Result + GetSingleKeyText(aKey, mustAddKeyPos);
      if (mustAddKeyPos) then
        AddKeyPos(initLength, LengthUTF8(Result));

      //Checks for keyIdxPos
      if GetKeyIdxPos(i, Result) then
        break;
    end;
  end;
end;

//Finds and returns the key in list of configurable keys using virtual key
function TKeyService.FindKeyConfig(iKey: word): TKey;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to ConfigKeys.Count - 1 do
  begin
    if ConfigKeys[i] <> nil then
      if ConfigKeys[i].Key = iKey then
      begin
        Result := ConfigKeys[i];
        break;
      end;
  end;
end;

//Finds and returns the key in list of configurable keys using string key
function TKeyService.FindKeyConfig(sKey: string): TKey;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to ConfigKeys.Count - 1 do
  begin
    if ConfigKeys[i] <> nil then
      if AnsiLowerCase(ConfigKeys[i].SaveValue) = AnsiLowerCase(sKey) then
      begin
        Result := ConfigKeys[i];
        break;
      end;
  end;

end;

function TKeyService.GetKeyConfig(iKey: word): TKey;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to ConfigKeys.Count - 1 do
  begin
    if ConfigKeys[i] <> nil then
      if ConfigKeys[i].Key = iKey then
      begin
        Result := ConfigKeys[i].CopyKey;
        break;
      end;
  end;
end;

function TKeyService.GetCoTriggerText(macro: TKeyList): string;
begin
  result := '';
  if (macro <> nil) then
  begin
    if macro.CoTrigger1 <> nil then
      result := macro.CoTrigger1.OtherDisplayText;

    if macro.CoTrigger2 <> nil then
    begin
      if (result <> '') then
        result := result + ' + ' + macro.CoTrigger2.OtherDisplayText
      else
        result := macro.CoTrigger2.OtherDisplayText;
    end;

    if macro.CoTrigger3 <> nil then
    begin
      if (result <> '') then
        result := result + ' + ' + macro.CoTrigger3.OtherDisplayText
      else
        result := macro.CoTrigger3.OtherDisplayText;
    end;

    if macro.CoTrigger4 <> nil then
    begin
      if (result <> '') then
        result := result + ' + ' + macro.CoTrigger4.OtherDisplayText
      else
        result := macro.CoTrigger4.OtherDisplayText;
    end;
  end;
end;

//Checks if modifier is already in list
function TKeyService.ModifierExits(key: word): boolean;
var
  i: integer;
  found: boolean;
begin
  found := False;

  for i := 0 to ActiveModifiers.Count - 1 do
  begin
    if ActiveModifiers[i] <> nil then
      if ActiveModifiers[i].Key = key then
      begin
        found := True; //already exists
        break;
      end;
  end;

  result := found;
end;

//Adds modifier to list of active modifiers
procedure TKeyService.AddModifier(key: word);
var
  aKey: TKey;
  newKey: TKey;
begin
  if (not ModifierExits(key)) then
  begin
    aKey := FindKeyConfig(key);
    if aKey <> nil then
    begin
      newKey := aKey.CopyKey;
      ActiveModifiers.Add(newKey);
    end;
  end;
end;

//Removes modifier from list of active modifiers
procedure TKeyService.RemoveModifier(key: word);
var
  i: integer;
  aKey: TKey;
begin
  aKey := FindKeyConfig(key);
  if aKey <> nil then
  begin
    for i := ActiveModifiers.Count - 1 downto 0 do
    begin
      if ActiveModifiers[i] <> nil then
        if ActiveModifiers[i].Key = aKey.Key then
          ActiveModifiers.Delete(i);
    end;
  end;
end;

procedure TKeyService.ClearModifiers;
begin
  if (ActiveModifiers <> nil) then
    ActiveModifiers.Clear;
end;

function TKeyService.IsWinKeyDown: boolean;
var
  i:integer;
begin
  result := false;

  for i := 0 to ActiveModifiers.Count - 1 do
    if ActiveModifiers.Items[i].Key in [VK_LWIN, VK_RWIN] then
      result := true;
end;

function TKeyService.AddKey(kbKey: TKBKey; iKey: word; modifiers: string; insertAtPos: integer): TKey;
var
  aKey: TKey;
begin
  Result := nil;
  if (kbKey <> nil) then
  begin
    aKey := GetKeyWithModifier(iKey, modifiers);
    if (aKey <> nil) then
    begin
      //Add keypress to active pedal
      if (insertAtPos >= 0) then
        kbKey.ActiveMacro.Insert(insertAtPos, aKey)
      else
        kbKey.ActiveMacro.Add(aKey);

      //Returns complet output text
      Result := aKey;
    end;
  end;
end;

function TKeyService.AddKeyMacro(macro: TKeyList; iKey: word; modifiers: string; insertAtPos: integer; upDown: TKeyState = ksNone): TKey;
var
  aKey: TKey;
begin
  Result := nil;
  if (macro <> nil) then
  begin
    aKey := GetKeyWithModifier(iKey, modifiers);
    if (aKey <> nil) then
    begin
      //Set Up/Down KS (only without modifiers)
      if (aKey.Modifiers = '') or (IsModifier(aKey.Key)) then
        aKey.UpDown := upDown;

      //Add keypress to active pedal
      if (insertAtPos >= 0) then
        macro.Insert(insertAtPos, aKey)
      else
        macro.Add(aKey);

      //Returns complet output text
      Result := aKey;
    end;
  end;
end;

function TKeyService.RemoveKey(kbKey: TKBKey; index: integer): boolean;
begin
  Result := false;
  if (kbKey <> nil) and (kbKey.IsMacro) then
  begin
    if (kbKey.ActiveMacro.Count >= index) and (index >= 0) then
    begin;
      kbKey.ActiveMacro.Remove(kbKey.ActiveMacro.Items[index]);
      result := true;
    end;
  end;
end;

function TKeyService.RemoveKeyMacro(macro: TKeyList; index: integer): boolean;
begin
  Result := false;
  if (macro <> nil) then
  begin
    if (macro.Count >= index) and (index >= 0) then
    begin;
      macro.Remove(macro.Items[index]);
      result := true;
    end;
  end;
end;

function TKeyService.RemoveDuplicateMacro(aMacro: TKeyList): boolean;
var
  i: integer;
  tempMacro: TKeyList;
begin
  Result := false;

  if (aMacro <> nil) then
  begin
    for i := 0 to FMacros.Count - 1 do
    begin
      tempMacro := TKeyList(FMacros[i]);

      if (tempMacro.TriggerKey = aMacro.TriggerKey) and (tempMacro.LayerIdx = aMacro.LayerIdx) and (not IsEqualGUID(tempMacro.Guid, aMacro.Guid)) then
      begin
        if (CompareTriggers(aMacro, tempMacro)) then
        begin
          FMacros.Delete(i);
          result := true;
          break;
        end;
      end;
    end;
  end;
end;

function TKeyService.GetInvalidLinesText(layerIdx: integer): string;
var
  i: integer;
begin
  result := '';
  //for i := 0 to Length(FInvalidLines) - 1 do
  //begin
  //  if ((layerIdx < 0) or (layerIdx = FInvalidLines[i].LayerIdx)) then
  //  begin
  //    if (result <> '') then
  //       result := result + #10#13;
  //    result := result + FInvalidLines[i].LineText;
  //  end;
  //end;
end;

function TKeyService.HasInvalidLines: boolean;
var
  i:integer;
begin
  result := false;
  for i := 0 to TextLines.Count - 1 do
  begin
    if (not TextLines[i].IsValid) and (not TextLines[i].Removed) then
      result := true;
  end;
end;

function TKeyService.GetMacroCount: integer;
var
  i, j:integer;
  aLayer: TKBLayer;
  aKbKey: TKBKey;
begin
  result := 0;
  if IsGen2Device(GApplication) then
  begin
    result := FMacros.Count;
  end
  else
  begin
    for i := 0 to FKBLayers.Count - 1 do
    begin
      aLayer := KBLayers[i];
      for j := 0 to aLayer.KBKeyList.Count - 1 do
      begin
        aKbKey := aLayer.KBKeyList[j];

        if (aKbKey.IsMacro) then
        begin
          if (aKbKey.Macro1.Count > 0) then
            inc(result);
          if (aKbKey.Macro2.Count > 0) then
            inc(result);
          if (aKbKey.Macro3.Count > 0) then
            inc(result);
          if (aKbKey.Macro4.Count > 0) then
            inc(result);
          if (aKbKey.Macro5.Count > 0) then
            inc(result);
        end;
      end;
    end;
  end;
end;

function TKeyService.GetModifierText: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to FActiveModifiers.Count - 1 do
  begin
    if Result <> '' then
      Result := Result + ',';
    Result := Result + GetKeyModifierText(FActiveModifiers.Items[i].Key);
  end;
end;

function TKeyService.BackupMacroKey(aKbKey: TKbKey): boolean;
begin
  result := false;
  if (aKbKey <> nil) then
  begin
    if (FBackupMacroKey <> nil) then
      FreeAndNil(FBackupMacroKey);
    FBackupMacroKey := TKBKey.Create;
    FBackupMacroKey.Assign(aKbKey, rtAll);
    result := true;
  end;
end;

function TKeyService.BackupMacro(aMacro: TKeyList): boolean;
begin
  result := false;
  if (aMacro <> nil) then
  begin
    if (FBackupMacro <> nil) then
      FreeAndNil(FBackupMacro);
    FBackupMacro := TKeyList.Create;
    FBackupMacro.Assign(aMacro);
    result := true;
  end;
end;

function TKeyService.RestoreMacro(aMacro: TKeyList): boolean;
begin
  result := false;
  if (aMacro <> nil) and (FBackupMacro <> nil) then
  begin
    aMacro.Assign(FBackupMacro);
    result := true;
  end;
end;

function TKeyService.RestoreMacroKey(aKbKey: TKbKey): boolean;
begin
  result := false;
  if (aKbKey <> nil) and (FBackupMacroKey <> nil) then
  begin
    aKbKey.Assign(FBackupMacroKey, rtMacro);
    result := true;
  end;
end;

function TKeyService.BackupKbKey(aKbKey: TKbKey): boolean;
begin
  result := false;
  if (aKbKey <> nil) then
  begin
    if (FBackupKey <> nil) then
      FreeAndNil(FBackupKey);
    FBackupKey := TKBKey.Create;
    FBackupKey.Assign(aKbKey, rtAll);
    result := true;
  end;
end;

function TKeyService.RestoreKbKey(aKbKey: TKbKey): boolean;
begin
  result := false;
  if (aKbKey <> nil) and (FBackupKey <> nil) then
  begin
    aKbKey.Assign(FBackupKey, rtKey);
    result := true;
  end;
end;

//Returns macro text
function TKeyService.GetMacroText(aKeyList: TKeyList; var aKeysPos: TKeysPos
  ): string;
var
  tmpInt: integer;
begin
  result := GetOutputText(aKeyList, aKeysPos, -1, tmpInt);
end;

//Returns key at specific position
function TKeyService.GetKeyAtPosition(aKeyList: TKeyList; cursorPos: integer
  ): integer;
var
  keyPos: integer;
  tmpKeysPos: TKeysPos;
begin
  keyPos := -1;
  GetOutputText(aKeyList, tmpKeysPos, cursorPos, keyPos);
  result := keyPos;
end;

//Converts text file content to layer/key values
procedure TKeyService.ConvertFromTextFileFmtFS(aLayoutContent: TStringList);
var
  aKey, newKey: TKey;
  sKey: string;
  keyState: TKeyState;
  keyStart, keyEnd: integer;
  lastKey: integer;
  previousKey: TKey;
  replacementKey: string;

  i: integer;
  tapHold: integer;
  currentLine: string;
  posSep: integer;
  isSingleKey: boolean;
  isMacro: boolean;
  isTapHold: boolean;
  isMultimodifier: boolean;
  isKeypadLayer: boolean;
  configText: string;
  valueText: string;
  aKBKey: TKBKey;
  layerIdx: integer;
  aCoTriggers: TKeyList;
  activeMacro: TKeyList;
  tempInt: integer;
begin
  lastKey := 0;
  aCoTriggers := TKeyList.Create;

  ResetLayout;

  if (aLayoutContent.Count > 0) then
  begin
    for i := 0 to aLayoutContent.Count - 1 do
    begin
      currentLine := TrimRight(AnsiLowerCase(aLayoutContent.Strings[i]));

      //Reset values
      isKeypadLayer := false;
      aCoTriggers.Clear;
      aKBKey := nil;
      activeMacro := nil;
      ClearModifiers;

      //Detect and remove fn text first
      isKeypadLayer := Pos(KEYPAD_KEY_EDGE, currentLine) <> 0;
      if (isKeypadLayer) then
      begin
        layerIdx := BOTLAYER_IDX;
        Delete(currentLine, 1, length(KEYPAD_KEY_EDGE)); //removes fn text
      end
      else
        layerIdx := TOPLAYER_IDX;

      posSep := Pos('>', currentLine);
      isSingleKey := Copy(currentLine, 1, 1) = SK_START;
      isMacro := Copy(currentLine, 1, 1) = MK_START;
      isTapHold := isSingleKey and (Pos('[' + TAP_AND_HOLD, currentLine) > 0);

      //Check if it's a valid line
      if (posSep <> 0) and (isSingleKey or isMacro or isTapHold) then
      begin
        configText := Copy(currentLine, 1, posSep - 1);
        valueText := Copy(currentLine, posSep + 1, Length(currentLine));
        isMultimodifier := isSingleKey and CheckMultimodifier(valueText);

        if (isTapHold) then
        begin
          //Load configured key
          keyStart := Pos(SK_START, configText);
          keyEnd := Pos(SK_END, configText);
          sKey := Copy(configText, keyStart + 1, keyEnd - 2);

          aKey := FindKeyConfig(sKey);

          //Gets key from layer
          if aKey <> nil then
            aKBKey := GetPositionKBKey(aKey.Key, layerIdx);

          if (aKBKey <> nil) then
          begin
            aKBKey.TapAndHold := true;
            //Load values for tap and hold
            for tapHold := 1 to 3 do
            begin
              keyStart := Pos(SK_START, valueText);
              keyEnd := Pos(SK_END, valueText);
              sKey := Copy(valueText, keyStart + 1, keyEnd - 2);
              Delete(valueText, 1, keyEnd); //removes currentkey

              //Sets modified key
              if (tapHold = 1) or (tapHold = 3) then
              begin
                aKey := FindKeyConfig(sKey);
                if aKey <> nil then
                begin
                  if (tapHold = 1) then
                    aKBKey.TapAction := aKey.CopyKey
                  else
                    aKBKey.HoldAction := aKey.CopyKey;
                end;
              end
              else
              begin
                sKey := Copy(sKey, Length(TAP_AND_HOLD) + 1, Length(sKey));
                aKBKey.TimingDelay := ConvertToInt(sKey, DEFAULT_SPEED_TAP_HOLD);
              end;
            end;
          end;
        end
        else if (isSingleKey) then
        begin
          //Load configured key
          keyStart := Pos(SK_START, configText);
          keyEnd := Pos(SK_END, configText);
          sKey := Copy(configText, keyStart + 1, keyEnd - 2);

          aKey := FindKeyConfig(sKey);

          //Gets key from layer
          if aKey <> nil then
            aKBKey := GetPositionKBKey(aKey.Key, layerIdx);

          if (aKBKey <> nil) then
          begin
            //Load value key
            keyStart := Pos(SK_START, valueText);
            keyEnd := Pos(SK_END, valueText);
            sKey := Copy(valueText, keyStart + 1, keyEnd - 2);

            if (isMultimodifier) then
            begin
              aKBKey.Multimodifiers := sKey;
            end
            else
            begin
              //Sets modified key
              aKey := FindKeyConfig(sKey);
              if aKey <> nil then
                SetKBKey(aKBKey, aKey.Key, false);
            end;
          end;
        end
        else if (isMacro) then
        begin
          //Loads key and co-triggers
          while (configText <> '') do
          begin
            aKey := nil;
            keyStart := Pos(MK_START, configText);
            keyEnd := Pos(MK_END, configText);
            sKey := Copy(configText, keyStart + 1, keyEnd - 2);
            Delete(configText, 1, keyEnd); //remove currentkey

            aKey := FindKeyConfig(sKey);
            if (aKey <> nil) then
            begin
              //If it is Key + modifier
              if (IsModifier(aKey.Key)) and (configText <> '') then
                aCoTriggers.Add(aKey.CopyKey)
              else
                aKBKey := GetPositionKBKey(aKey.Key, layerIdx, true);
            end;
          end;

          //Loads active Macro
          if (aKBKey <> nil) then
          begin
            if (aKBKey.Macro1.Count = 0) then
              activeMacro := aKBKey.Macro1
            else if (aKBKey.Macro2.Count = 0) then
              activeMacro := aKBKey.Macro2
            else if (aKBKey.Macro3.Count = 0) then
              activeMacro := aKBKey.Macro3
            else if (aKBKey.Macro4.Count = 0) then
              activeMacro := aKBKey.Macro4
            else if (aKBKey.Macro5.Count = 0) then
              activeMacro := aKBKey.Macro5;
          end;

          //If kbKey and activeMacro, load values
          if (aKBKey <> nil) and (activeMacro <> nil) and (aKBKey.CanAssignMacro) then
          begin
            aKBKey.IsMacro := true;

            if (aCoTriggers.Count >= 1) then
              activeMacro.CoTrigger1 := aCoTriggers[0].CopyKey;

            activeMacro.MacroSpeed := 0;
            activeMacro.MacroRptFreq := 0;

            //Get Macro text
            while (valueText <> '') do
            begin
              aKey := nil;
              keyStart := Pos(MK_START, valueText);
              keyEnd := Pos(MK_END, valueText);
              sKey := Copy(valueText, keyStart + 1, keyEnd - 2);
              if copy(sKey, 1, 1) = '-' then  //Checks for keyup or keydown
                keyState := ksDown
              else if copy(sKey, 1, 1) = '+' then
                keyState := ksUp
              else
                keyState := ksNone;
              if keyState <> ksNone then
                Delete(sKey, 1, 1); //removes - or +
              Delete(valueText, 1, keyEnd); //removes currentkey

              if (activeMacro.Count = 0) and
                (Length(sKey) > 1) and
                (Copy(sKey, 1, Length(MACRO_SPEED_TEXT_EDGE)) = MACRO_SPEED_TEXT_EDGE) and
                (IsNumber(sKey, Length(MACRO_SPEED_TEXT_EDGE) + 1)) then
              begin
                tempInt := ConvertToInt(Copy(sKey, Length(MACRO_SPEED_TEXT_EDGE) + 1, Length(MACRO_SPEED_TEXT_EDGE) + 2));
                if (tempInt >= MACRO_SPEED_MIN_FS) and (tempInt <= MACRO_SPEED_MAX_FS) then
                  activeMacro.MacroSpeed := tempInt
                else
                  activeMacro.MacroSpeed := DEFAULT_MACRO_SPEED_FS;
              end
              else if (activeMacro.Count = 0) and
                (Length(sKey) > 1) and
                (Copy(sKey, 1, Length(MACRO_REPEAT_EDGE)) = MACRO_REPEAT_EDGE) and
                (IsNumber(sKey, Length(MACRO_REPEAT_EDGE) + 1)) then
              begin
                tempInt := ConvertToInt(Copy(sKey, Length(MACRO_REPEAT_EDGE) + 1, Length(MACRO_REPEAT_EDGE) + 2));
                if (tempInt >= MACRO_FREQ_MIN_FS) and (tempInt <= MACRO_FREQ_MAX_FS) then
                  activeMacro.MacroRptFreq := tempInt
                else
                  activeMacro.MacroRptFreq := DEFAULT_MACRO_FREQ_FS;
              end
              else
              begin
                aKey := FindKeyConfig(sKey);

                //Checks for replacement key values (US English)
                if aKey <> nil then
                begin
                  replacementKey := GetReplacementKey(aKey.Key, false);
                  if (replacementKey <> '') then
                    aKey := FindKeyConfig(replacementKey);
                end;
              end;

              if aKey <> nil then
              begin
                if IsModifier(aKey.Key) then
                begin
                  //Adds to list of active modifiers
                  if (keyState = ksDown) then
                    AddModifier(aKey.key)
                  else if (keyState = ksUp) then
                  begin
                    //If last key is the same key, then adds modifier as single key down
                    if lastKey = aKey.Key then
                      activeMacro.Add(aKey.CopyKey);
                    RemoveModifier(aKey.Key);
                  end
                  else //if no keyState (+ or -) and modifier add as single key
                    activeMacro.Add(aKey.CopyKey);
                end
                else if (keyState in [ksNone, ksDown]) then //Only add key on key down or key none
                begin
                  //Get the previous key
                  if activeMacro.Count > 0 then
                    previousKey := activeMacro.Items[activeMacro.Count - 1];

                  //If there are modifiers and we find Different Press and Release, we assign it to previous key
                  if (ActiveModifiers.Count > 0) and (aKey.Key = VK_DIF_PRESS_REL) and (previousKey <> nil) then
                  begin
                    previousKey.DiffPressRel := true;
                  end
                  else //Add the key
                  begin
                    newKey := akey.CopyKey;
                    newKey.Modifiers := GetModifierText; //Gets modifier values
                    activeMacro.Add(newKey); //Adds key
                  end;
                end;
                lastKey := aKey.Key;
              end;
            end; //end while loop valueText
          end;
        end;
      end;
    end;
  end;
  ClearModifiers;
end;

function TKeyService.ConvertToTextFileFmtFS: TStringList;
var
  i, j: integer;
  lIdx, kIdx, mIdx: integer;
  lineText: string;
  saveValue: string;
  layoutContent: TStringList;
  aLayer: TKBLayer;
  aKbKey: TKBKey;
  aKey: TKey;
  aMacro: TKeyList;
  layerPrefix: string;
  prevModifiers: string;
  curKeyModifiers: TKeyList;
  prevKeyModifiers: TKeyList;
  textLine: TTextLine;
begin
  layoutContent := TStringList.Create;

  for lIdx := 0 to FKBLayers.Count - 1 do
  begin
    layerPrefix := '';
    aLayer := FKBLayers[lIdx];
    if (aLayer.LayerIndex = BOTLAYER_IDX) then
      layerPrefix := KEYPAD_KEY_EDGE;

    for kIdx := 0 to aLayer.KBKeyList.Count - 1 do
    begin
      lineText := '';
      aKbKey := aLayer.KBKeyList[kIdx];

      //If key is tap and hold
      if (aKbKey.TapAndHold) and (aKbKey.TapAction <> nil) and (aKbKey.HoldAction <> nil) then
      begin
        lineText := layerPrefix + '[' + aKbKey.PositionKey.SaveValue + ']>[' + aKbKey.TapAction.SaveValue + ']' +
          '[' + TAP_AND_HOLD + IntToStr(aKbKey.TimingDelay) + ']' + '[' + aKbKey.HoldAction.SaveValue + ']';
        layoutContent.Add(lineText);
      end
      //If key is modified / remapped
      else if (aKbKey.IsModified) then
      begin
        lineText := layerPrefix + '[' + aKbKey.PositionKey.SaveValue + ']>[' + aKbKey.ModifiedKey.SaveValue + ']';
        layoutContent.Add(lineText);
      end;

      //jm todo Can be modified and have macro??
      //jm todo Do we put fn for macro values??
      if (aKbKey.IsMacro) then
      begin
        curKeyModifiers := TKeyList.Create;
        prevKeyModifiers := TKeyList.Create;

        //Loop through the 3 macros
        for mIdx := 1 to 3 do
        begin
          lineText := '';

          //Select the correct macro
          if (mIdx = 1) then
            aMacro := aKbKey.Macro1
          else if (mIdx = 2) then
            aMacro := aKbKey.Macro2
          else if (mIdx = 3) then
            aMacro := aKbKey.Macro3
          else if (mIdx = 4) then
            aMacro := aKbKey.Macro4
          else
            aMacro := aKbKey.Macro5;

          //Skip if macro has no keys
          if (aMacro.Count <= 0) then
            continue;

          //Add layer prefix if there
          lineText := lineText + layerPrefix;

          //Add the co-triggers first
          if (aMacro.CoTrigger1 <> nil) then
            lineText := lineText + '{' + aMacro.CoTrigger1.SaveValue + '}';

          //Add the modified key
          lineText := lineText + '{' + aKbKey.PositionKey.SaveValue + '}';

          //Add the character separating config and value keys
          lineText := lineText + '>';

          if (aMacro.MacroSpeed >= 1) and (aMacro.MacroSpeed <= MACRO_SPEED_MAX_FS) then
          begin
            lineText := lineText + '{' + MACRO_SPEED_TEXT_EDGE + IntToStr(aMacro.MacroSpeed) + '}';
          end;

          if (aMacro.MacroRptFreq >= 1) and (aMacro.MacroRptFreq <= MACRO_FREQ_MAX_FS) then
          begin
            lineText := lineText + '{' + MACRO_REPEAT_EDGE + IntToStr(aMacro.MacroRptFreq) + '}';
          end;

          for i := 0 to aMacro.Count - 1 do
          begin
            prevModifiers := '';
            curKeyModifiers.Clear;
            prevKeyModifiers.Clear;;

            aKey := aMacro[i];

            //Gets the key save value
            saveValue := aKey.SaveValue;

            //Fills list of modifiers
            if not IsModifier(aKey.Key) then
              FillModifiersFromValues(curKeyModifiers, aKey.Modifiers);

            //Loads previous key modifiers
            if (i >= 1) and not(IsModifier(aMacro[i - 1].Key)) then
            begin
              prevModifiers := aMacro[i - 1].Modifiers;
              FillModifiersFromValues(prevKeyModifiers, prevModifiers);
            end;

            //Checks any change in modifiers (add or remove any)
            if (prevModifiers <> aKey.Modifiers) then
            begin
              //Add text + when modifier is released
              for j := 0 to prevKeyModifiers.Count - 1 do
              begin
                if not curKeyModifiers.ContrainsKey(prevKeyModifiers[j]) then
                  lineText := lineText + '{+' + prevKeyModifiers.Items[j].SaveValue + '}';
              end;

              //Add text - when modifier is pressed
              for j := 0 to curKeyModifiers.Count - 1 do
              begin
                if not prevKeyModifiers.ContrainsKey(curKeyModifiers[j]) then
                  lineText := lineText + '{-' + curKeyModifiers.Items[j].SaveValue + '}';
              end;
            end;

            //If different press & release with combination, write using the old method with up and down value
            if (aKey.DiffPressRel) then
            begin
              //Writes the key - and + if WriteDownUp is enabled, else writes only the value
              if aKey.WriteDownUp then
                lineText := lineText + '{-' + saveValue + '}' + DIFF_PRESS_REL_TEXT + '{+' + saveValue + '}'
              else
                lineText := lineText + '{' + saveValue + '}';
            end
            else  //Write the key value, only need the - / + for modifiers
              lineText := lineText + '{' + saveValue + '}';

            //If last key set modifiers +
            if (i = aMacro.Count - 1) then
            begin
              for j := 0 to curKeyModifiers.Count - 1 do
                lineText := lineText + '{+' + curKeyModifiers[j].SaveValue + '}';
            end;
          end;

          //Add line to text file
          layoutContent.Add(lineText);
        end;

        FreeAndNil(curKeyModifiers);
        FreeAndNil(prevKeyModifiers);
      end;
    end;

    //Invalid lines to keep
    for kIdx := 0 to TextLines.Count - 1 do
    begin
      textLine := TextLines[kIdx];
      if ((not textLine.IsValid) and (textLine.LayerIdx = aLayer.LayerIndex)) then
      begin
        if (textLine.Keep and (not textLine.Removed)) then
          layoutContent.Add(textLine.RawText)
        else
          textLine.Removed := true;
      end;
    end;
  end;

  Result := layoutContent;
end;

//Check if valid layout file
function TKeyService.IsLayoutFile(aContent: TStringList): boolean;
var
  I: integer;
  posSep: integer;
  currentLine: string;
  configText: string;
  valueText: string;
  isSingleKey: boolean;
  isMacro: boolean;
  isColorValue: boolean;
  isTapHold: boolean;
  isKeypadLayer: boolean;
begin
  result := false;
  if (aContent.Count > 0) then
  begin
    for i := 0 to aContent.Count - 1 do
    begin
      currentLine := TrimRight(AnsiLowerCase(aContent.Strings[i]));

      //Detect and remove fn text first
      isKeypadLayer := Pos(KEYPAD_KEY_EDGE, currentLine) <> 0;
      if (isKeypadLayer) then
        Delete(currentLine, 1, length(KEYPAD_KEY_EDGE)); //removes fn text

      posSep := Pos('>', currentLine);
      isSingleKey := Copy(currentLine, 1, 1) = SK_START;
      isMacro := Copy(currentLine, 1, 1) = MK_START;
      isTapHold := isSingleKey and (Pos('[' + TAP_AND_HOLD, currentLine) > 0);

      //Check if it's a valid line
      if (posSep <> 0) and (isSingleKey or isMacro or isTapHold) then
        result := true;
    end;
  end;
end;

//Converts text file content to layer/key values
procedure TKeyService.ConvertFromTextFileFmt(aLayoutContent: TStringList);
var
  aKey, newKey: TKey;
  sKey: string;
  keyState: TKeyState;
  lastKeyState: TKeyState;
  keyStart, keyEnd: integer;
  lastKey: integer;
  previousKey: TKey;
  replacementKey: string;

  i: integer;
  tapHold: integer;
  currentLine: string;
  posSep: integer;
  isSingleKey: boolean;
  isMacro: boolean;
  isTapHold: boolean;
  isMultimodifier: boolean;
  isKeypadLayer: boolean;
  configText: string;
  valueText: string;
  aKBKey: TKBKey;
  layerIdx: integer;
  aCoTriggers: TKeyList;
  activeMacro: TKeyList;
  tempInt: integer;
  curLayerIdx: integer;
  isValidConfig: bool;
  isValidValue: bool;
  tapAction: TKey;
  holdAction: TKey;
  timingDelay: integer;
  macroSpeed: integer;
  macroRptFreq: integer;
  configSegment: string;
  valueSegment: string;
  macroSegment: string;
  textLine: TTextLine;
  lineId: integer;

  procedure AddLineSegment(text: string; isValid: boolean);
  var
    lineSegment: TLineSegment;
  begin
    lineSegment := TLineSegment.Create(text, isValid);
    textLine.Add(lineSegment);
  end;

  procedure AddLine(line: TTextLine);
  begin
    FTextLines.Add(line);
  end;

begin
  lastKey := 0;
  lastKeyState := ksNone;
  curLayerIdx := 0;
  lineId := 0;
  aCoTriggers := TKeyList.Create;

  FMacros.Clear;
  ResetLayout;

  if (aLayoutContent.Count > 0) then
  begin
    for i := 0 to aLayoutContent.Count - 1 do
    begin
      inc(lineId);
      isValidConfig := false;
      isValidValue := false;
      configSegment := '';
      valueSegment := '';
      currentLine := TrimRight(AnsiLowerCase(aLayoutContent.Strings[i]));

      //Reset values
      isKeypadLayer := false;
      aCoTriggers.Clear;
      aKBKey := nil;
      activeMacro := nil;
      ClearModifiers;

      if (IsGen2Device(GApplication)) then
      begin
        if (currentLine.StartsWith(ADV360_LAYER_PREFIX) and currentLine.EndsWith(ADV360_LAYER_SUFFIX)) then
        begin
          isValidValue := true;
          isValidConfig := true;

          if (currentLine = TEXT_LAYER_DEFAULT) then
            curLayerIdx := LAYER_BASE_360
          else if (currentLine = TEXT_LAYER_KP) then
            curLayerIdx := LAYER_KEYPAD_360
          else if (currentLine = TEXT_LAYER_FN1) then
            curLayerIdx := LAYER_FN1_360
          else if (currentLine = TEXT_LAYER_FN2) then
            curLayerIdx := LAYER_FN2_360
          else if (currentLine = TEXT_LAYER_FN3) then
            curLayerIdx := LAYER_FN3_360
          else
          begin
            isValidValue := false;
            isValidConfig := false;
          end;
        end;
        layerIdx := curLayerIdx;
      end
      else
      begin
        //Detect and remove fn text first
        isKeypadLayer := Pos(KEYPAD_KEY_EDGE, currentLine) <> 0;
        if (isKeypadLayer) then
        begin
          layerIdx := BOTLAYER_IDX;
          Delete(currentLine, 1, length(KEYPAD_KEY_EDGE)); //removes fn text
        end
        else
          layerIdx := TOPLAYER_IDX;
      end;

      textLine := TTextLine.Create(lineId, layerIdx);
      textLine.RawText := currentLine;

      posSep := Pos(SEPARATOR, currentLine);
      if (posSep > 0) then
      begin
         configText := Copy(currentLine, 1, posSep - 1);
         valueText := Copy(currentLine, posSep + 1, Length(currentLine));
      end
      else
      begin
         configText := Copy(currentLine, 1, Length(currentLine));
         valueText := '';
      end;
      configSegment := configText;
      valueSegment := valueText;

      isSingleKey := (Pos(SK_START, configText) > 0) or (Pos(SK_END, configText) > 0); //Copy(configText, 1, 1) = SK_START;
      isMacro := (Pos(MK_START, configText) > 0) or (Pos(MK_END, configText) > 0) ;   //Copy(configText, 1, 1) = MK_START;
      isTapHold := isSingleKey and (Pos('[' + TAP_AND_HOLD, valueText) > 0); //Has more than one value on the right
      isMultimodifier := isSingleKey and CheckMultimodifier(valueText);

      //Check if it's a valid line
      if (posSep <> 0) and (isSingleKey or isMacro or isTapHold) then
      begin
        if (isSingleKey or isTapHold) then
        begin
          isValidConfig := (Copy(configText, 1, 1) = SK_START) and (Pos(SK_END, configText) > 0);

          //Load configured key
          keyStart := 1;//Pos(SK_START, configText);
          keyEnd := Pos(SK_END, configText);
          if (keyEnd = 0) then
            keyEnd := Length(configText);
          sKey := Copy(configText, keyStart + 1, keyEnd - 2);

          aKey := FindKeyConfig(sKey);

          //Gets key from layer
          if aKey <> nil then
            aKBKey := GetPositionKBKey(aKey.Key, layerIdx);

          isValidConfig := isValidConfig and (aKBKey <> nil);

          AddLineSegment(configSegment, isValidConfig);
          AddLineSegment(SEPARATOR, true);
        end
        else if (isMacro) then
          isValidConfig := (Copy(configText, 1, 1) = MK_START) and (Pos(MK_END, configText) > 0);

        if (isTapHold) then
        begin
          tapAction := nil;
          holdAction := nil;
          timingDelay := -1;

          //Load values for tap and hold
          for tapHold := 1 to 3 do
          begin
            keyStart := 1;//Pos(SK_START, valueText);
            keyEnd := Pos(SK_END, valueText);
            sKey := Copy(valueText, keyStart + 1, keyEnd - 2);
            Delete(valueText, 1, keyEnd); //removes currentkey

            //Sets modified key
            if (tapHold = 1) or (tapHold = 3) then
            begin
              aKey := FindKeyConfig(sKey);
              if aKey <> nil then
              begin
                if (tapHold = 1) then
                  tapAction := aKey.CopyKey //aKBKey.TapAction := aKey.CopyKey
                else
                  holdAction := aKey.CopyKey; //aKBKey.HoldAction := aKey.CopyKey;
              end;
            end
            else
            begin
              sKey := Copy(sKey, Length(TAP_AND_HOLD) + 1, Length(sKey));
              timingDelay := ConvertToInt(sKey); //aKBKey.TimingDelay :=
            end;
          end;

          isValidValue := (tapAction <> nil) and (holdAction <> nil) and (timingDelay >= 0);
          if (isValidValue) and (isValidConfig) then
          begin
            aKBKey.TapAndHold := true;
            aKBKey.TapAction := tapAction;
            aKBKey.HoldAction := holdAction;
            aKBKey.TimingDelay := timingDelay;
          end;

          AddLineSegment(valueSegment, isValidValue);
        end
        else if (isSingleKey) then
        begin
          //Load value key
          keyStart := 1;//Pos(SK_START, valueText);
          keyEnd := Pos(SK_END, valueText);
          sKey := Copy(valueText, keyStart + 1, keyEnd - 2);

          if (isMultimodifier) and (sKey <> '') then
          begin
            if (aKBKey <> nil) then
               aKBKey.Multimodifiers := sKey;
            isValidValue := true;
          end
          else
          begin
            //Sets modified key
            aKey := FindKeyConfig(sKey);
            if aKey <> nil then
            begin
              if (aKBKey <> nil) then
                 SetKBKey(aKBKey, aKey.Key, false);
              isValidValue := true;
            end;
          end;
          AddLineSegment(valueSegment, isValidValue);
        end
        else if (isMacro) then
        begin
          //Loads key and co-triggers (left side)
          if (isValidConfig) then
          begin
            while (configText <> '') do
            begin
              aKey := nil;
              keyStart := 1;//Pos(MK_START, configText);
              keyEnd := Pos(MK_END, configText);
              sKey := Copy(configText, keyStart + 1, keyEnd - 2);
              Delete(configText, 1, keyEnd); //remove currentkey

              aKey := FindKeyConfig(sKey);
              if (aKey <> nil) then
              begin
                //If it is Key + modifier
                if (IsModifier(aKey.Key)) and (configText <> '') then
                  aCoTriggers.Add(aKey.CopyKey)
                else
                begin
                  if IsGen2Device(GApplication) then
                    aKBKey := GetKBKeyTrigger(aKey.Key)
                  else
                    aKBKey := GetPositionKBKey(aKey.Key, layerIdx, true);

                  if (aKBKey = nil) then
                     isValidConfig := false;
                end;
              end
              else
                isValidConfig := false;
            end;
          end;

          AddLineSegment(configSegment, isValidConfig);
          AddLineSegment(SEPARATOR, true);

          //Load macro (right side)
          activeMacro := TKeyList.Create;
          macroSpeed := -1;
          macroRptFreq := -1;

          //Get Macro text
          while (valueText <> '') do
          begin
            //For macros, sets isValidValue as true, and invalidates it if not valid
            isValidValue := true;
            aKey := nil;
            keyStart := 1; //Pos(MK_START, valueText);
            keyEnd := Pos(MK_END, valueText);
            if (keyEnd = 0) then
              keyEnd := Length(valueText);
            macroSegment := Copy(valueText, keyStart, keyEnd); //include MK_START and MK_END
            sKey := Copy(valueText, keyStart + 1, keyEnd - 2);
            if copy(sKey, 1, 1) = '-' then  //Checks for keyup or keydown
              keyState := ksDown
            else if copy(sKey, 1, 1) = '+' then
              keyState := ksUp
            else
              keyState := ksNone;
            if keyState <> ksNone then
              Delete(sKey, 1, 1); //removes - or +
            Delete(valueText, 1, keyEnd); //removes currentkey
            if (keyEnd = 0) then
              Delete(valueText, 1, Length(valueText)); //Removes rest if not keyEnd

            //Load macro speed
            if (activeMacro.Count = 0) and
              (Length(sKey) > 1) and
              (Copy(sKey, 1, Length(MACRO_SPEED_TEXT_EDGE)) = MACRO_SPEED_TEXT_EDGE) and
              (IsNumber(sKey, Length(MACRO_SPEED_TEXT_EDGE) + 1)) then
            begin
              tempInt := ConvertToInt(Copy(sKey, Length(MACRO_SPEED_TEXT_EDGE) + 1, Length(MACRO_SPEED_TEXT_EDGE) + 2));
              if (tempInt >= 0{MACRO_SPEED_MIN}) and (tempInt <= MACRO_SPEED_MAX_RGB) then
                macroSpeed := tempInt;

              //Check minimum multiplay for each device
              if (GActiveDevice.DeviceNumber = APPL_ADV360) then
              begin
                if (macroSpeed < MACRO_SPEED_MIN_ADV360) then
                  macroSpeed := MACRO_SPEED_MIN_ADV360;
              end;
              AddLineSegment(macroSegment, true);
            end
            else if (activeMacro.Count = 0) and  //Load macro multiplay
              (Length(sKey) > 1) and
              (Copy(sKey, 1, Length(MACRO_REPEAT_EDGE)) = MACRO_REPEAT_EDGE) and
              (IsNumber(sKey, Length(MACRO_REPEAT_EDGE) + 1)) then
            begin
              tempInt := ConvertToInt(Copy(sKey, Length(MACRO_REPEAT_EDGE) + 1, Length(MACRO_REPEAT_EDGE) + 2));
              if (tempInt >= 0{MACRO_FREQ_MIN}) and (tempInt <= MACRO_FREQ_MAX_RGB) then
                macroRptFreq := tempInt;

              //Check minimum multiplay for each device
              if (GActiveDevice.DeviceNumber = APPL_ADV360) then
              begin
                if (macroRptFreq < MACRO_FREQ_MIN_ADV360) then
                  macroRptFreq := MACRO_FREQ_MIN_ADV360;
              end;
              AddLineSegment(macroSegment, true);
            end
            else
            begin
              aKey := nil;
              if (sKey <> '') then
                 aKey := FindKeyConfig(sKey);

              //Checks for replacement key values (US English)
              if aKey <> nil then
              begin
                replacementKey := GetReplacementKey(aKey.Key, false);
                if (replacementKey <> '') then
                  aKey := FindKeyConfig(replacementKey);
              end;

              if (aKey <> nil) then
              begin
                if IsModifier(aKey.Key) then
                begin
                  if (keyState = ksDown) then
                  begin
                    //Adds to list of active modifiers
                    AddModifier(aKey.key);
                  end
                  else if (keyState = ksUp) then
                  begin
                    //If last key is the same key or just key up, then adds modifier as single key down
                    if (lastKey = aKey.Key) or not(ModifierExits(aKey.Key)) then
                    begin
                      newKey := akey.CopyKey;
                      //Gen2 device, mark as UP only if last key was different or if last key was the same and not DOWN
                      if (IsGen2Device(GApplication)) and ((lastKey <> aKey.Key) or (lastKeyState <> ksDown))  then
                        newKey.UpDown := keyState;
                      activeMacro.Add(newKey);
                    end;
                    RemoveModifier(aKey.Key);
                  end
                  else //if no keyState (+ or -) and modifier add as single key
                    activeMacro.Add(aKey.CopyKey);
                end
                else
                begin
                  if (GApplication = APPL_PEDAL) then
                  begin
                    //Only add key on key down or key none
                    if (keyState in [ksNone, ksDown]) then
                    begin
                      //Get the previous key
                      if activeMacro.Count > 0 then
                        previousKey := activeMacro.Items[activeMacro.Count - 1];

                      //If there are modifiers and we find Different Press and Release, we assign it to previous key
                      if (ActiveModifiers.Count > 0) and (aKey.Key = VK_DIF_PRESS_REL) and (previousKey <> nil) then
                      begin
                        previousKey.DiffPressRel := true;
                      end
                      else //Add the key
                      begin
                        newKey := akey.CopyKey;
                        newKey.UpDown := keyState;
                        newKey.Modifiers := GetModifierText; //Gets modifier values
                        activeMacro.Add(newKey); //Adds key
                      end;
                    end;
                  end
                  else
                  begin
                    newKey := akey.CopyKey;
                    newKey.UpDown := keyState;
                    newKey.Modifiers := GetModifierText; //Gets modifier values
                    activeMacro.Add(newKey); //Adds key
                  end;
                end;
                lastKey := aKey.Key;
                lastKeyState := keyState;
              end
              else
                isValidValue := false;

              AddLineSegment(macroSegment, isValidValue);
            end;
          end; //end while loop valueText

          if (isValidValue) and (isValidConfig) and (activeMacro <> nil) and (aKBKey.CanAssignMacro) then
          begin
            if (aCoTriggers.Count >= 1) then
              activeMacro.CoTrigger1 := aCoTriggers[0].CopyKey;
            if (aCoTriggers.Count >= 2) then
              activeMacro.CoTrigger2 := aCoTriggers[1].CopyKey;
            if (aCoTriggers.Count >= 3) then
              activeMacro.CoTrigger3 := aCoTriggers[2].CopyKey;
            if (aCoTriggers.Count >= 4) then
              activeMacro.CoTrigger4 := aCoTriggers[3].CopyKey;

            //Set macro speed and multiplay
            if (macroSpeed <> -1) then
              activeMacro.MacroSpeed := macroSpeed
            else
              activeMacro.MacroSpeed := DEFAULT_MACRO_SPEED_RGB;
            if (macroRptFreq <> -1) then
              activeMacro.MacroRptFreq := macroRptFreq
            else
              activeMacro.MacroRptFreq := DEFAULT_MACRO_FREQ_RGB;

            if IsGen2Device(GApplication) then
            begin
              activeMacro.TriggerKey := aKBKey.OriginalKey.Key;
              activeMacro.LayerIdx := layerIdx;
              FMacros.Add(activeMacro);
            end
            else
            begin
              aKBKey.IsMacro := true;
              //Loads active Macro
              if (aKBKey.Macro1.Count = 0) then
                aKBKey.Macro1.Assign(activeMacro, true)
              else if (aKBKey.Macro2.Count = 0) then
                aKBKey.Macro2.Assign(activeMacro, true)
              else if (aKBKey.Macro3.Count = 0) then
                aKBKey.Macro3.Assign(activeMacro, true)
              else if (aKBKey.Macro4.Count = 0) then
                aKBKey.Macro4.Assign(activeMacro, true)
              else if (aKBKey.Macro5.Count = 0) then
                aKBKey.Macro5.Assign(activeMacro, true);

              FreeAndNil(activeMacro);
            end;
          end;
        end;
      end
      else //Whole line marked as invalid
        AddLineSegment(currentLine, isValidValue and isValidConfig);

      AddLine(textLine);
    end;
  end;

  ClearModifiers;
  if (aCoTriggers <> nil) then
    FreeAndNil(aCoTriggers);
end;

function TKeyService.ConvertLedToTextFileFmt: TStringList;
var
  kIdx: integer;
  lineText: string;
  layoutContent: TStringList;
  aLayer: TKBLayer;
  aKbKey: TKBKey;
  aKbKeyTopLayer: TKBKey;
  perKeyColors: boolean;
  sColor: string;
  keysSaved: boolean;
  lIdx: integer;
  layerPrefix: string;
  aLedMode: TLedMode;
  keyExcept: TKey;
begin
  layoutContent := TStringList.Create;
  perKeyColors := false;
  keysSaved := false;

  for lIdx := 0 to FKBLayers.Count - 1 do
  begin
    perKeyColors := false;
    layerPrefix := '';
    aLedMode := FLedMode;
    aLayer := FKBLayers[lIdx];
    if (aLayer.LayerIndex = BOTLAYER_IDX) then
    begin
      layerPrefix := KEYPAD_KEY_EDGE;
      aLedMode := FLedModeFn;
    end;

    if (aLedMode <> lmDisabled) then
    begin
      case aLedMode of
        lmFreestyle:
        begin
          perKeyColors := true;
        end;
        lmMonochrome:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FLedColorMono, true))
          else
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FLedColorMonoFn, true));
        end;
        lmBreathe:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            layoutContent.Add(layerPrefix + LED_BREATHE + '>' + LedSpeedToString(FLedSpeed))
          else
            layoutContent.Add(layerPrefix + LED_BREATHE + '>' + LedSpeedToString(FLedSpeedFn));
          perKeyColors := true;
        end;
        lmSpectrum:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            layoutContent.Add(layerPrefix + LED_SPECTRUM + '>' + LedSpeedToString(FLedSpeed))
          else
            layoutContent.Add(layerPrefix + LED_SPECTRUM + '>' + LedSpeedToString(FLedSpeedFn));
        end;
        lmWave:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            layoutContent.Add(layerPrefix + LED_WAVE + '>' + LedSpeedToString(FLedSpeed) + LedDirectionToString(FLedDirection))
          else
            layoutContent.Add(layerPrefix + LED_WAVE + '>' + LedSpeedToString(FLedSpeedFn) + LedDirectionToString(FLedDirectionFn));
        end;
        lmReactive:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorReactive, true));
            layoutContent.Add(layerPrefix + LED_REACTIVE + '>' + RGBColorToString(FLedColorReactive, true) + LedSpeedToString(FLedSpeed));
          end
          else
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorReactiveFn, true));
            layoutContent.Add(layerPrefix + LED_REACTIVE + '>' + RGBColorToString(FLedColorReactiveFn, true) + LedSpeedToString(FLedSpeedFn));
          end;
        end;
        lmRipple:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorRipple, true));
            layoutContent.Add(layerPrefix + LED_RIPPLE + '>' + RGBColorToString(FLedColorRipple, true) + LedSpeedToString(FLedSpeed));
          end
          else
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorRippleFn, true));
            layoutContent.Add(layerPrefix + LED_RIPPLE + '>' + RGBColorToString(FLedColorRippleFn, true) + LedSpeedToString(FLedSpeedFn));
          end;
        end;
        lmFireball:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorFireball, true));
            layoutContent.Add(layerPrefix + LED_FIREBALL + '>' + RGBColorToString(FLedColorFireball, true) + LedSpeedToString(FLedSpeed) + LedDirectionToString(FLedDirection));
          end
          else
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorFireballFn, true));
            layoutContent.Add(layerPrefix + LED_FIREBALL + '>' + RGBColorToString(FLedColorFireballFn, true) + LedSpeedToString(FLedSpeedFn) + LedDirectionToString(FLedDirectionFn));
          end;
        end;
        lmStarlight:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorStarlight, true));
            layoutContent.Add(layerPrefix + LED_STARLIGHT + '>' + RGBColorToString(FLedColorStarlight, true) + LedSpeedToString(FLedSpeed));
          end
          else
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorStarlightFn, true));
            layoutContent.Add(layerPrefix + LED_STARLIGHT + '>' + RGBColorToString(FLedColorStarlightFn, true) + LedSpeedToString(FLedSpeedFn));
          end;
        end;
        lmRebound:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorRebound, true));
            layoutContent.Add(layerPrefix + LED_REBOUND + '>' + RGBColorToString(FLedColorRebound, true) + LedSpeedToString(FLedSpeed) + LedDirectionToString(FLedDirection));
          end
          else
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorReboundFn, true));
            layoutContent.Add(layerPrefix + LED_REBOUND + '>' + RGBColorToString(FLedColorReboundFn, true) + LedSpeedToString(FLedSpeedFn) + LedDirectionToString(FLedDirectionFn));
          end;
        end;
        lmLoop:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorLoop, true));
            layoutContent.Add(layerPrefix + LED_LOOP + '>' + RGBColorToString(FLedColorLoop, true) + LedSpeedToString(FLedSpeed) + LedDirectionToString(FLedDirection));
          end
          else
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorLoopFn, true));
            layoutContent.Add(layerPrefix + LED_LOOP + '>' + RGBColorToString(FLedColorLoopFn, true) + LedSpeedToString(FLedSpeedFn) + LedDirectionToString(FLedDirectionFn));
          end;
        end;
        lmPulse:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            layoutContent.Add(layerPrefix + LED_PULSE + '>' + LedSpeedToString(FLedSpeed))
          else
            layoutContent.Add(layerPrefix + LED_PULSE + '>' + LedSpeedToString(FLedSpeedFn));
        end;
        lmRain:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorRain, true));
            layoutContent.Add(layerPrefix + LED_RAIN + '>' + RGBColorToString(FLedColorRain, true) + LedSpeedToString(FLedSpeed));
          end
          else
          begin
            layoutContent.Add(layerPrefix + LED_MONO + '>' + RGBColorToString(FBaseLedColorRainFn, true));
            layoutContent.Add(layerPrefix + LED_RAIN + '>' + RGBColorToString(FLedColorRainFn, true) + LedSpeedToString(FLedSpeedFn));
          end;
        end;
        //lmPitchBlack:
        //begin
        //  layoutContent.Add(layerPrefix + LED_PITCH_BLACK);
        //end;
      end;

      if (perKeyColors) then
      begin
        //Only first layer for lighting
        //aLayer := FKBLayers[0];

        for kIdx := 0 to aLayer.KBKeyList.Count - 1 do
        begin
          lineText := '';
          aKbKey := aLayer.KBKeyList[kIdx];
          //Get key from top layer to save
          aKbKeyTopLayer := FKBLayers[TOPLAYER_IDX].KBKeyList[kIdx];

          if (aKbKey.KeyColor <> clNone) then
          begin
            sColor :=  RGBColorToString(aKbKey.KeyColor);
            if (sColor <> '') then
            begin
              keysSaved := true;
              keyExcept := GetKeySaveException(aKbKeyTopLayer.PositionKey.Key, aLayer.LayerIndex);
              if (keyExcept <> nil) then
                lineText := '[' + keyExcept.SaveValue + ']>' + sColor
              else
                lineText := '[' + aKbKeyTopLayer.PositionKey.SaveValue + ']>' + sColor;

              //Add line to text file
              layoutContent.Add(layerPrefix + lineText);
            end;
          end;
        end;
      end;

      //If no color configured, set mono color to none
      if (LedMode = lmBreathe) and (not keysSaved) then
      begin
        layoutContent.Add(LED_MONO + '>' + RGBColorToString(clNone, true));
      end;
    end;
  end;
  Result := layoutContent;
end;

function TKeyService.ConvertLedToTextFileFmtAdv360: TStringList;
var
  indIdx: integer;
  layoutContent: TStringList;
  ledInd: TLedInd;
  indStr: string;
begin
  layoutContent := TStringList.Create;

  for indIdx := 0 to FLedIndicators.Count - 1 do
  begin
    ledInd := FLedIndicators[indIdx];
    indStr := UpperCase(LED_IND_START) + IntToStr(indIdx + 1) + ']>';
    //if (ledInd.FnToken = ifGameMode) then
    //  layoutContent.Add(indStr + '[game]' + RGBColorToString(ledInd.IndColor[0], true))
    if (ledInd.FnToken = ifNKRO) then
      layoutContent.Add(indStr + LED_NKRO + RGBColorToString(ledInd.IndColor[0], true))
    else if (ledInd.FnToken = ifScrollLock) then
      layoutContent.Add(indStr + LED_SCROLL_LOCK + RGBColorToString(ledInd.IndColor[0], true))
    else if (ledInd.FnToken = ifNumLock) then
      layoutContent.Add(indStr + LED_NUM_LOCK + RGBColorToString(ledInd.IndColor[0], true))
    else if (ledInd.FnToken = ifCaps) then
      layoutContent.Add(indStr + LED_CAPS + RGBColorToString(ledInd.IndColor[0], true))
    else if (ledInd.FnToken = ifLayer) then
    begin
      layoutContent.Add(indStr + '[layd]' + RGBColorToString(ledInd.IndColor[0], true));
      layoutContent.Add(indStr + '[layk]' + RGBColorToString(ledInd.IndColor[1], true));
      layoutContent.Add(indStr + '[lay1]' + RGBColorToString(ledInd.IndColor[2], true));
      layoutContent.Add(indStr + '[lay2]' + RGBColorToString(ledInd.IndColor[3], true));
      layoutContent.Add(indStr + '[lay3]' + RGBColorToString(ledInd.IndColor[4], true));
    end
    else if (ledInd.FnToken = ifProfile) then
      layoutContent.Add(indStr + LED_PROFILE + RGBColorToString(ledInd.IndColor[0], true))
    else if (ledInd.FnToken = ifBattery) then
      layoutContent.Add(indStr + LED_BATTERY)
    else if (ledInd.FnToken = ifDisable) then
      layoutContent.Add(indStr + LED_NULL);
  end;

  Result := layoutContent;
end;

function TKeyService.ConvertEdgeToTextFileFmt: TStringList;
var
  kIdx: integer;
  lineText: string;
  edgeContent: TStringList;
  aLayer: TKBLayer;
  aKbKey: TKBKey;
  perKeyColors: boolean;
  sColor: string;
  keysSaved: boolean;
  lIdx: integer;
  layerPrefix: string;
  aEdgeMode: TLedMode;
  keyExcept: TKey;
begin
  edgeContent := TStringList.Create;
  perKeyColors := false;
  keysSaved := false;

  for lIdx := 0 to FKBLayers.Count - 1 do
  begin
    perKeyColors := false;
    layerPrefix := '';
    aEdgeMode := FEdgeMode;
    aLayer := FKBLayers[lIdx];
    if (aLayer.LayerIndex = BOTLAYER_IDX) then
    begin
      layerPrefix := KEYPAD_KEY_EDGE;
      aEdgeMode := FEdgeModeFn;
    end;

    if (aEdgeMode <> lmDisabled) then
    begin
      case aEdgeMode of
        lmFreestyle:
        begin
          perKeyColors := true;
        end;
        lmMonochrome:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            edgeContent.Add(layerPrefix + EDGE_MONO + '>' + RGBColorToString(FEdgeColorMono, true))
          else
            edgeContent.Add(layerPrefix + EDGE_MONO + '>' + RGBColorToString(FEdgeColorMonoFn, true));
        end;
        lmBreathe:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            edgeContent.Add(layerPrefix + EDGE_BREATHE + '>' + LedSpeedToString(FEdgeSpeed))
          else
            edgeContent.Add(layerPrefix + EDGE_BREATHE + '>' + LedSpeedToString(FEdgeSpeedFn));
          perKeyColors := true;
        end;
        lmSpectrum:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            edgeContent.Add(layerPrefix + EDGE_SPECTRUM + '>' + LedSpeedToString(FEdgeSpeed))
          else
            edgeContent.Add(layerPrefix + EDGE_SPECTRUM + '>' + LedSpeedToString(FEdgeSpeedFn));
        end;
        lmWave:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            edgeContent.Add(layerPrefix + EDGE_WAVE + '>' + LedSpeedToString(FEdgeSpeed) + LedDirectionToString(FEdgeDirection))
          else
            edgeContent.Add(layerPrefix + EDGE_WAVE + '>' + LedSpeedToString(FEdgeSpeedFn) + LedDirectionToString(FEdgeDirection));
        end;
        lmFrozenWave:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            edgeContent.Add(layerPrefix + EDGE_FROZENWAVE)
          else
            edgeContent.Add(layerPrefix + EDGE_FROZENWAVE);
          perKeyColors := true;
        end;
        lmRebound:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            edgeContent.Add(layerPrefix + EDGE_MONO + '>' + RGBColorToString(FBaseEdgeColorRebound, true));
            edgeContent.Add(layerPrefix + EDGE_REBOUND + '>' + RGBColorToString(FEdgeColorRebound, true) + LedSpeedToString(FEdgeSpeed));
          end
          else
          begin
            edgeContent.Add(layerPrefix + EDGE_MONO + '>' + RGBColorToString(FBaseEdgeColorReboundFn, true));
            edgeContent.Add(layerPrefix + EDGE_REBOUND + '>' + RGBColorToString(FEdgeColorReboundFn, true) + LedSpeedToString(FEdgeSpeedFn));
          end;
        end;
        lmLoop:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
          begin
            edgeContent.Add(layerPrefix + EDGE_MONO + '>' + RGBColorToString(FBaseEdgeColorLoop, true));
            edgeContent.Add(layerPrefix + EDGE_LOOP + '>' + RGBColorToString(FEdgeColorLoop, true) + LedSpeedToString(FEdgeSpeed) + LedDirectionToString(FEdgeDirection));
          end
          else
          begin
            edgeContent.Add(layerPrefix + EDGE_MONO + '>' + RGBColorToString(FBaseEdgeColorLoopFn, true));
            edgeContent.Add(layerPrefix + EDGE_LOOP + '>' + RGBColorToString(FEdgeColorLoopFn, true) + LedSpeedToString(FEdgeSpeedFn) + LedDirectionToString(FEdgeDirectionFn));
          end;
        end;
        lmPulse:
        begin
          if aLayer.LayerIndex = TOPLAYER_IDX then
            edgeContent.Add(layerPrefix + EDGE_PULSE + '>' + LedSpeedToString(FEdgeSpeed))
          else
            edgeContent.Add(layerPrefix + EDGE_PULSE + '>' + LedSpeedToString(FEdgeSpeedFn));
        end;
      end;

      if (perKeyColors) then
      begin
        for kIdx := 0 to aLayer.EdgeKeyList.Count - 1 do
        begin
          lineText := '';
          aKbKey := aLayer.EdgeKeyList[kIdx];

          if (aKbKey.KeyColor <> clNone) then
          begin
            sColor :=  RGBColorToString(aKbKey.KeyColor);
            if (sColor <> '') then
            begin
              keysSaved := true;
              keyExcept := GetKeySaveException(aKbKey.PositionKey.Key, aLayer.LayerIndex);
              if (keyExcept <> nil) then
                lineText := '[' + keyExcept.SaveValue + ']>' + sColor
              else
                lineText := '[' + aKbKey.PositionKey.SaveValue + ']>' + sColor;

              //Add line to text file
              edgeContent.Add(layerPrefix + lineText);
            end;
          end;
        end;
      end;

      //If no color configured, set mono color to none
      if (FEdgeMode = lmBreathe) and (not keysSaved) then
      begin
        edgeContent.Add(EDGE_MONO + '>' + RGBColorToString(clNone, true));
      end;
    end;
  end;
  Result := edgeContent;
end;

function TKeyService.GetKeyLoadException(key: word; layerIdx: integer): TKey;
begin
  result := nil;
  if (layerIdx = BOTLAYER_IDX) then
  begin
    case key of
      VK_F1: result := GetKeyConfig(VK_VOLUME_MUTE);
      VK_F2: result := GetKeyConfig(VK_VOLUME_DOWN);
      VK_F3: result := GetKeyConfig(VK_VOLUME_UP);
      VK_F4: result := GetKeyConfig(VK_MEDIA_PLAY_PAUSE);
      VK_F5: result := GetKeyConfig(VK_MEDIA_PREV_TRACK);
      VK_F6: result := GetKeyConfig(VK_MEDIA_NEXT_TRACK);
      VK_PAUSE: result := GetKeyConfig(VK_INSERT);
      VK_DELETE: result := GetKeyConfig(VK_SCROLL);
    end;
  end;
end;

function TKeyService.GetKeySaveException(key: word; layerIdx: integer): TKey;
begin
  result := nil;
  if (layerIdx = BOTLAYER_IDX) then
  begin
    case key of
      VK_VOLUME_MUTE: result := GetKeyConfig(VK_F1);
      VK_VOLUME_DOWN: result := GetKeyConfig(VK_F2);
      VK_VOLUME_UP: result := GetKeyConfig(VK_F3);
      VK_MEDIA_PLAY_PAUSE: result := GetKeyConfig(VK_F4);
      VK_MEDIA_PREV_TRACK: result := GetKeyConfig(VK_F5);
      VK_MEDIA_NEXT_TRACK: result := GetKeyConfig(VK_F6);
      VK_INSERT: result := GetKeyConfig(VK_PAUSE);
      VK_SCROLL: result := GetKeyConfig(VK_DELETE);
    end;
  end;
end;

procedure TKeyService.SetAllKeyColor(keyColor: TColor; layerIdx: integer);
var
  keyIdx: integer;
  aLayer: TKBLayer;
  aKey: TKBKey;
begin
  aLayer := GetLayer(layerIdx);

  if (aLayer <> nil) then
  begin
    for keyIdx := 0 to aLayer.KBKeyList.Count - 1 do
    begin
      aKey := aLayer.KBKeyList[keyIdx];
      aKey.KeyColor := keyColor;
    end;
  end;
end;

procedure TKeyService.SetAllKeyColorEdge(keyColor: TColor; layerIdx: integer);
var
  keyIdx: integer;
  aLayer: TKBLayer;
  aKey: TKBKey;
begin
  aLayer := GetLayer(layerIdx);

  if (aLayer <> nil) then
  begin
    for keyIdx := 0 to aLayer.EdgeKeyList.Count - 1 do
    begin
      aKey := aLayer.EdgeKeyList[keyIdx];
      aKey.KeyColor := keyColor;
    end;
  end;
end;

procedure TKeyService.SetAllIndColor(indIdx: integer; keyColor: TColor);
begin
  FLedIndicators[indIdx].SetAllColor(keyColor);
end;

function TKeyService.GetKeyWithModifier(iKey: word; modifiers: string): TKey;
var
  aKey: TKey;
  newKey: TKey;
begin
  Result := nil;
  aKey := FindKeyConfig(iKey);
  if (aKey <> nil) then
  begin
    newKey := aKey.CopyKey;
    if not(IsModifier(iKey)) then
      newKey.Modifiers := modifiers;

    Result := newKey;
  end;
end;

//Check if file content is from Led file
function TKeyService.IsLedFile(aContent: TStringList): boolean;
var
  lineCount: integer;
  posSep: integer;
  firstLine: string;
  configText: string;
  valueText: string;
  isSingleKey: boolean;
  isColorValue: boolean;
begin
  result := false;
  if (aContent.Count > 0) then
  begin
    lineCount := aContent.Count;

    //Check first line for Led Mode
    firstLine := AnsiLowerCase(aContent.Strings[0]);

    if (GApplication = APPL_ADV360) then
    begin
      result := (pos(LED_IND_START, firstLine) <> 0);
    end
    else
    begin
      posSep := Pos('>', firstLine);
      isSingleKey := Copy(firstLine, 1, 1) = SK_START;

      //Check if it's a valid line
      if (posSep <> 0) and (isSingleKey) then
      begin
        configText := Copy(firstLine, 1, posSep - 1);
        valueText := Copy(firstLine, posSep + 1, Length(firstLine));

        //Has more than one [ in value text
        isColorValue := Pos(SK_START, Copy(valueText, 2, Length(valueText))) <> 0;

        result := (pos(LED_MONO, firstLine) <> 0) or
          (pos(LED_BREATHE, firstLine) <> 0) or
          (pos(LED_SPECTRUM, firstLine) <> 0) or
          (pos(LED_WAVE, firstLine) <> 0) or
          (pos(LED_REACTIVE, firstLine) <> 0) or
          (pos(LED_STARLIGHT, firstLine) <> 0) or
          (pos(LED_REBOUND, firstLine) <> 0) or
          (pos(LED_RIPPLE, firstLine) <> 0) or
          (pos(LED_FIREBALL, firstLine) <> 0) or
          (pos(LED_LOOP, firstLine) <> 0) or
          (pos(LED_PULSE, firstLine) <> 0) or
          (pos(LED_RAIN, firstLine) <> 0) or
          (pos(EDGE_MONO, firstLine) <> 0) or
          (pos(EDGE_BREATHE, firstLine) <> 0) or
          (pos(EDGE_SPECTRUM, firstLine) <> 0) or
          (pos(EDGE_WAVE, firstLine) <> 0) or
          (pos(EDGE_REBOUND, firstLine) <> 0) or
          (pos(EDGE_LOOP, firstLine) <> 0) or
          (pos(EDGE_PULSE, firstLine) <> 0) or
          (pos(EDGE_FROZENWAVE, firstLine) <> 0) or
          isColorValue;
      end;
    end;
  end;
end;

procedure TKeyService.ResetLedOptions;
var
  i: integer;
begin
  SetAllKeyColor(clNone, TOPLAYER_IDX);
  SetAllKeyColor(clNone, BOTLAYER_IDX);
  FLedMode := lmDisabled;
  FLedModeFn := lmDisabled;
  FLedColorMono := DEFAULT_LED_COLOR;
  FLedColorMonoFn := DEFAULT_LED_COLOR;
  FLedColorReactive := DEFAULT_LED_COLOR;
  FLedColorReactiveFn := DEFAULT_LED_COLOR;
  FBaseLedColorReactive := DEFAULT_LED_COLOR_BASE;
  FBaseLedColorReactiveFn := DEFAULT_LED_COLOR_BASE;
  FLedColorRipple := DEFAULT_LED_COLOR;
  FLedColorRippleFn := DEFAULT_LED_COLOR;
  FBaseLedColorRipple := DEFAULT_LED_COLOR_BASE;
  FBaseLedColorRippleFn := DEFAULT_LED_COLOR_BASE;
  FLedColorFireball := DEFAULT_LED_COLOR;
  FLedColorFireballFn := DEFAULT_LED_COLOR;
  FBaseLedColorFireball := DEFAULT_LED_COLOR_BASE;
  FBaseLedColorFireballFn := DEFAULT_LED_COLOR_BASE;
  FLedColorStarlight := DEFAULT_LED_COLOR;
  FLedColorStarlightFn := DEFAULT_LED_COLOR;
  FBaseLedColorStarlight := DEFAULT_LED_COLOR_BASE;
  FBaseLedColorStarlightFn := DEFAULT_LED_COLOR_BASE;
  FLedColorRebound := DEFAULT_LED_COLOR;
  FLedColorReboundFn := DEFAULT_LED_COLOR;
  FBaseLedColorRebound := DEFAULT_LED_COLOR_BASE;
  FBaseLedColorReboundFn := DEFAULT_LED_COLOR_BASE;
  FLedColorLoop := DEFAULT_LED_COLOR;
  FLedColorLoopFn := DEFAULT_LED_COLOR;
  FBaseLedColorLoop := DEFAULT_LED_COLOR_BASE;
  FBaseLedColorLoopFn := DEFAULT_LED_COLOR_BASE;
  FLedColorRain := DEFAULT_LED_COLOR;
  FLedColorRainFn := DEFAULT_LED_COLOR;
  FBaseLedColorRain := DEFAULT_LED_COLOR_BASE;
  FBaseLedColorRainFn := DEFAULT_LED_COLOR_BASE;
  FLedSpeed := DEFAULT_LED_SPEED;
  FLedSpeedFn := DEFAULT_LED_SPEED;
  FLedDirection := DEFAULT_LED_DIR_INT;
  FLedDirectionFn := DEFAULT_LED_DIR_INT;
  FLedIndicators.ResetAll;
end;

procedure TKeyService.ResetEdgeOptions;
begin
  SetAllKeyColorEdge(clNone, TOPLAYER_IDX);
  SetAllKeyColorEdge(clNone, BOTLAYER_IDX);
  FEdgeMode := lmDisabled;
  FEdgeModeFn := lmDisabled;
  FEdgeColorMono := DEFAULT_LED_COLOR;
  FEdgeColorMonoFn := DEFAULT_LED_COLOR;
  FEdgeColorRebound := DEFAULT_LED_COLOR;
  FEdgeColorReboundFn := DEFAULT_LED_COLOR;
  FBaseEdgeColorRebound := DEFAULT_LED_COLOR_BASE;
  FBaseEdgeColorReboundFn := DEFAULT_LED_COLOR_BASE;
  FEdgeColorLoop := DEFAULT_LED_COLOR;
  FEdgeColorLoopFn := DEFAULT_LED_COLOR;
  FBaseEdgeColorLoop := DEFAULT_LED_COLOR_BASE;
  FBaseEdgeColorLoopFn := DEFAULT_LED_COLOR_BASE;
  FEdgeSpeed := DEFAULT_LED_SPEED;
  FEdgeSpeedFn := DEFAULT_LED_SPEED;
  FEdgeDirection := DEFAULT_LED_DIR_INT;
  FEdgeDirectionFn := DEFAULT_LED_DIR_INT;
end;

function TKeyService.GetLedSpeedFile(var sSpeed: string): integer;
var
  sValue: string;
  iValue: integer;
  keyStart, keyEnd: integer;
begin
  result := DEFAULT_LED_SPEED;

  //Load led speed
  keyStart := Pos(SK_START, sSpeed);
  keyEnd := Pos(SK_END, sSpeed);
  sValue := Copy(sSpeed, keyStart + 1, keyEnd - 2);
  Delete(sSpeed, 1, keyEnd); //removes value

  if (pos(LED_SPEED_EDGE, sValue) > 0) and (Length(sValue) > 1) and
    (IsNumber(sValue, Length(LED_SPEED_EDGE) + 1)) then
  begin
     iValue := ConvertToInt(Copy(sValue, Length(LED_SPEED_EDGE) + 1));
     if (iValue >= LED_SPEED_MIN) and (iValue <= LED_SPEED_MAX) then
        result := iValue
  end;
end;

function TKeyService.GetLedDirectionFile(var sDirection: string): integer;
var
  sValue: string;
  sDir: string;
  keyStart, keyEnd: integer;
begin
  result := 0;

  //Load led direction
  keyStart := Pos(SK_START, sDirection);
  keyEnd := Pos(SK_END, sDirection);
  sValue := Copy(sDirection, keyStart + 1, keyEnd - 2);
  Delete(sDirection, 1, keyEnd); //removes value

  if (pos(LED_DIR_EDGE, sValue) > 0) then
  begin
    sDir := Copy(sValue, Length(LED_DIR_EDGE) + 1);
    if (sDir = LED_DIR_LEFT) then
      result := LED_DIR_LEFT_INT
    else if (sDir = LED_DIR_RIGHT) then
      result := LED_DIR_RIGHT_INT
    else if (sDir = LED_DIR_UP) then
      result := LED_DIR_UP_INT
    else
      result := LED_DIR_DOWN_INT;
  end;
end;

procedure TKeyService.ConvertLedFromTextFileFmt(aLedContent: TStringList);
var
  aKey: TKey;
  sKey: string;
  keyStart, keyEnd: integer;
  i: integer;
  currentLine: string;
  secondLine: string;
  posSep: integer;
  isSingleKey: boolean;
  configText: string;
  valueText: string;
  aKBKey: TKBKey;
  aKBKeyBotLayer: TKBKey;
  lineCount: integer;
  isKeypadLayer: boolean;
  aLedMode: TLedMode;
  layerIdx: integer;
  aColor: TColor;
  aLedTopLayer: TStringList;
  aLedBotLayer: TStringList;
  keyExcept: TKey;
begin
  ResetLedOptions;

  try
    aLedTopLayer := TStringList.Create;
    aLedBotLayer := TStringList.Create;

    //Split content in 2 string lists
    if (aLedContent.Count > 0) then
    begin
      for i:= 0 to aLedContent.Count - 1 do
      begin
        currentLine := TrimRight(AnsiLowerCase(aLedContent.Strings[i]));
        if (Pos(KEYPAD_KEY_EDGE, currentLine) <> 0) then
          aLedBotLayer.Add(currentLine)
        else
          aLedTopLayer.Add(currentLine);
      end;
    end;

    //2 passes, first for top layer then bottom layer
    for layerIdx := TOPLAYER_IDX to BOTLAYER_IDX do
    begin
      if (layerIdx = TOPLAYER_IDX) then
        aLedContent := aLedTopLayer
      else
        aLedContent := aLedBotLayer;

      lineCount := aLedContent.Count;
      if (lineCount > 0) then
      begin
        //First line is led mode
        currentLine := TrimRight(AnsiLowerCase(aLedContent.Strings[0]));
        secondLine := '';
        if (lineCount > 1) then
          secondLine := TrimRight(AnsiLowerCase(aLedContent.Strings[1]));

        if (layerIdx = BOTLAYER_IDX) then
          Delete(currentLine, 1, length(KEYPAD_KEY_EDGE)); //removes fn text

        //Mono only if 1 line, else it's freestyle with mono option
        if (pos(LED_MONO, currentLine) > 0) and (lineCount = 1) then
        begin
          aLedMode := lmMonochrome;
          lineCount := 1;
        end
        else if (pos(LED_BREATHE, currentLine) > 0) THEN
          aLedMode := lmBreathe
        else if (pos(LED_SPECTRUM, currentLine) > 0) THEN
        begin
          aLedMode := lmSpectrum;
          lineCount := 1;
        end
        else if (pos(LED_WAVE, currentLine) > 0) THEN
        begin
          aLedMode := lmWave;
          lineCount := 1;
        end
        else if (pos(LED_REACTIVE, currentLine) > 0) or (pos(LED_REACTIVE, secondLine) > 0) THEN
        begin
          aLedMode := lmReactive;
          lineCount := 2;
        end
        else if (pos(LED_FIREBALL, currentLine) > 0) or (pos(LED_FIREBALL, secondLine) > 0) THEN
        begin
          aLedMode := lmFireball;
          lineCount := 2;
        end
        else if (pos(LED_STARLIGHT, currentLine) > 0) or (pos(LED_STARLIGHT, secondLine) > 0) THEN
        begin
          aLedMode := lmStarlight;
          lineCount := 2;
        end
        else if (pos(LED_REBOUND, currentLine) > 0) or (pos(LED_REBOUND, secondLine) > 0) THEN
        begin
          aLedMode := lmRebound;
          lineCount := 2;
        end
        else if (pos(LED_RIPPLE, currentLine) > 0) or (pos(LED_RIPPLE, secondLine) > 0) THEN
        begin
          aLedMode := lmRipple;
          lineCount := 2;
        end
        else if (pos(LED_LOOP, currentLine) > 0) or (pos(LED_LOOP, secondLine) > 0) THEN
        begin
          aLedMode := lmLoop;
          lineCount := 2;
        end
        else if (pos(LED_PULSE, currentLine) > 0) THEN
        begin
          aLedMode := lmPulse;
          lineCount := 1;
        end
        else if (pos(LED_RAIN, currentLine) > 0) or (pos(LED_RAIN, secondLine) > 0) THEN
        begin
          aLedMode := lmRain;
          lineCount := 2;
        end
        //else if (pos(LED_PITCH_BLACK, currentLine) > 0) THEN
        //begin
        //  aLedMode := lmPitchBlack;
        //  lineCount := 1;
        //end
        else if (currentLine = '') then
          aLedMode := lmDisabled
        else
          aLedMode := lmFreestyle;

        if (layerIdx = BOTLAYER_IDX) then
          FLedModeFn := aLedMode
        else
          FLedMode := aLedMode;

        for i := 0 to lineCount - 1 do
        begin
          if (aLedContent.Count > i) then
          begin
            currentLine := AnsiLowerCase(aLedContent.Strings[i]);
            if (currentLine <> '') then
            begin
              //Check if it's keypad layer
              if (layerIdx = BOTLAYER_IDX) then
                Delete(currentLine, 1, length(KEYPAD_KEY_EDGE)); //removes fn text

              //Reset values
              aKBKey := nil;

              posSep := Pos('>', currentLine);
              isSingleKey := Copy(currentLine, 1, 1) = SK_START;

              //Check if it's a valid line
              if (posSep <> 0) and (isSingleKey) then
              begin
                configText := Copy(currentLine, 1, posSep - 1);
                valueText := Copy(currentLine, posSep + 1, Length(currentLine));

                if (aLedMode = lmFreestyle) or ((i > 0) and (aLedMode = lmBreathe)) then
                begin
                  //If mono tag, then set color for all keys
                  if (pos(LED_MONO, currentLine) > 0) then
                  begin
                    SetAllKeyColor(RGBStringToColor(valueText, clNone), layerIdx);
                  end
                  else
                  begin
                    //Load configured key
                    keyStart := Pos(SK_START, configText);
                    keyEnd := Pos(SK_END, configText);
                    sKey := Copy(configText, keyStart + 1, keyEnd - 2);

                    aKey := FindKeyConfig(sKey);

                    //Gets key from top layer
                    if aKey <> nil then
                    begin
                      keyExcept := GetKeyLoadException(aKey.Key, TOPLAYER_IDX);
                      if (keyExcept <> nil) then
                        aKBKey := GetPositionKBKey(keyExcept.Key, TOPLAYER_IDX)
                      else
                        aKBKey := GetPositionKBKey(aKey.Key, TOPLAYER_IDX);
                    end;
                  end;
                end;

                if (aKBKey <> nil) and (aLedMode in [lmFreestyle, lmBreathe]) then
                begin
                  //Bot layer get key index from top layer to set color
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    aKBKeyBotLayer := FKBLayers[BOTLAYER_IDX].KBKeyList[aKBKey.Index];
                    if (aKBKeyBotLayer <> nil) then
                      aKBKeyBotLayer.KeyColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  end
                  else
                    aKBKey.KeyColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                end
                else if (aLedMode = lmBreathe) and (i = 0) then
                begin
                  if (layerIdx = BOTLAYER_IDX) then
                    FLedSpeedFn := GetLedSpeedFile(valueText)
                  else
                    FLedSpeed := GetLedSpeedFile(valueText);
                end
                else if (aLedMode in [lmReactive, lmRipple, lmFireball, lmStarlight, lmRebound, lmLoop, lmRain]) and (i = 0) then //Mono first line
                begin
                  if (pos(LED_MONO, currentLine) > 0) then
                  begin
                    aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR_BASE);
                    case aLedMode of
                      lmReactive:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseLedColorReactiveFn := aColor
                        else
                          FBaseLedColorReactive := aColor;
                      end;
                      lmRipple:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseLedColorRippleFn := aColor
                        else
                          FBaseLedColorRipple := aColor;
                      end;
                      lmFireball:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseLedColorFireballFn := aColor
                        else
                          FBaseLedColorFireball := aColor;
                      end;
                      lmStarlight:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseLedColorStarlightFn := aColor
                        else
                          FBaseLedColorStarlight := aColor;
                      end;
                      lmRebound:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseLedColorReboundFn := aColor
                        else
                          FBaseLedColorRebound := aColor;
                      end;
                      lmLoop:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseLedColorLoopFn := aColor
                        else
                          FBaseLedColorLoop := aColor;
                      end;
                      lmRain:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseLedColorRainFn := aColor
                        else
                          FBaseLedColorRain := aColor;
                      end;
                    end;
                  end;
                end
                else if (aLedMode = lmMonochrome) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                    FLedColorMonoFn := aColor
                  else
                    FLedColorMono := aColor;
                end
                else if (aLedMode in [lmSpectrum]) then
                begin
                  if (layerIdx = BOTLAYER_IDX) then
                    FLedSpeedFn := GetLedSpeedFile(valueText)
                  else
                    FLedSpeed := GetLedSpeedFile(valueText);
                end
                else if (aLedMode = lmWave) then
                begin
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FLedSpeedFn := GetLedSpeedFile(valueText);
                    FLedDirectionFn := GetLedDirectionFile(valueText);
                  end
                  else
                  begin
                    FLedSpeed := GetLedSpeedFile(valueText);
                    FLedDirection := GetLedDirectionFile(valueText);
                  end;
                end
                else if (aLedMode = lmReactive) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FLedColorReactiveFn := aColor;
                    FLedSpeedFn := GetLedSpeedFile(valueText);
                  end;
                  begin
                    FLedColorReactive := aColor;
                    FLedSpeed := GetLedSpeedFile(valueText);
                  end;
                end
                else if (aLedMode = lmRipple) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FLedColorRippleFn := aColor;
                    FLedSpeedFn := GetLedSpeedFile(valueText);
                  end;
                  begin
                    FLedColorRipple := aColor;
                    FLedSpeed := GetLedSpeedFile(valueText);
                  end;
                end
                else if (aLedMode = lmFireball) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FLedColorFireballFn := aColor;
                    FLedSpeedFn := GetLedSpeedFile(valueText);
                    FLedDirectionFn := GetLedDirectionFile(valueText);
                    if not(FLedDirectionFn in [LED_DIR_LEFT_INT, LED_DIR_RIGHT_INT]) then
                      FLedDirectionFn := DEFAULT_LED_DIR_INT;
                  end;
                  begin
                    FLedColorFireball := aColor;
                    FLedSpeed := GetLedSpeedFile(valueText);
                    FLedDirection := GetLedDirectionFile(valueText);
                    if not(FLedDirection in [LED_DIR_LEFT_INT, LED_DIR_RIGHT_INT]) then
                      FLedDirection := DEFAULT_LED_DIR_INT;
                  end;
                end
                else if (aLedMode = lmStarlight) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FLedColorStarlightFn := aColor;
                    FLedSpeedFn:= GetLedSpeedFile(valueText);
                  end
                  else
                  begin
                    FLedColorStarlight := aColor;
                    FLedSpeed := GetLedSpeedFile(valueText);
                  end;
                end
                else if (aLedMode = lmRebound) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FLedColorReboundFn := aColor;
                    FLedSpeedFn := GetLedSpeedFile(valueText);
                    FLedDirectionFn := GetLedDirectionFile(valueText);
                    if not(FLedDirectionFn in [LED_DIR_LEFT_INT, LED_DIR_UP_INT]) then
                      FLedDirectionFn := DEFAULT_LED_DIR_INT;
                  end
                  else
                  begin
                    FLedColorRebound := aColor;
                    FLedSpeed := GetLedSpeedFile(valueText);
                    FLedDirection := GetLedDirectionFile(valueText);
                    if not(FLedDirection in [LED_DIR_LEFT_INT, LED_DIR_UP_INT]) then
                      FLedDirection := DEFAULT_LED_DIR_INT;
                  end;
                end
                else if (aLedMode = lmLoop) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FLedColorLoopFn := aColor;
                    FLedSpeedFn := GetLedSpeedFile(valueText);
                    FLedDirectionFn := GetLedDirectionFile(valueText);
                  end
                  else
                  begin
                    FLedColorLoop := aColor;
                    FLedSpeed := GetLedSpeedFile(valueText);
                    FLedDirection := GetLedDirectionFile(valueText);
                  end;
                end
                else if (aLedMode = lmPulse) then
                begin
                  if (layerIdx = BOTLAYER_IDX) then
                    FLedSpeedFn := GetLedSpeedFile(valueText)
                  else
                    FLedSpeed := GetLedSpeedFile(valueText);
                end
                else if (aLedMode = lmRain) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FLedColorRainFn := aColor;
                    FLedSpeedFn := GetLedSpeedFile(valueText);
                  end
                  else
                  begin
                    FLedColorRain := aColor;
                    FLedSpeed := GetLedSpeedFile(valueText);
                  end;
                end
              end;
            end;
          end;
        end;
      end;
    end;
  finally
    if (aLedTopLayer <> nil) then
      FreeAndNil(aLedTopLayer);
    if (aLedBotLayer <> nil) then
      FreeAndNil(aLedBotLayer);
  end;
end;

procedure TKeyService.ConvertLedFromTextFileFmtAdv360(aLedContent: TStringList);
var
  i: integer;
  currentLine: string;
  posSep: integer;
  configText: string;
  valueText: string;
  lineCount: integer;
  ledInd: TLedInd;

  procedure GetFunctionToken(var valueText: string);
  begin
    ledInd.FnToken := ifDisable;
    ledInd.LayerIdx := 0;

    if (pos(LED_NKRO, valueText) <> 0) then
    begin
      ledInd.FnToken := ifNKRO;
      Delete(valueText, 1, 6);
    end
    //else if (pos('[game]', valueText) <> 0) then
    //begin
    //  ledInd.FnToken := ifGameMode;
    //  Delete(valueText, 1, 6);
    //end
    else if (pos(LED_PROFILE, valueText) <> 0) then
    begin
      ledInd.FnToken := ifProfile;
      Delete(valueText, 1, 6);
    end
    else if (pos(LED_CAPS, valueText) <> 0) then
    begin
      ledInd.FnToken := ifCaps;
      Delete(valueText, 1, 6);
    end
    else if (pos(LED_NUM_LOCK, valueText) <> 0) then
    begin
      ledInd.FnToken := ifNumLock;
      Delete(valueText, 1, 6);
    end
    else if (pos(LED_SCROLL_LOCK, valueText) <> 0) then
    begin
      ledInd.FnToken := ifScrollLock;
      Delete(valueText, 1, 6);
    end
    else if (pos(LED_BATTERY, valueText) <> 0) then
    begin
      ledInd.FnToken := ifBattery;
      Delete(valueText, 1, 6);
    end
    else if (pos(LED_NULL, valueText) <> 0) then
    begin
      ledInd.FnToken := ifDisable;
      Delete(valueText, 1, 6);
    end
    else if (pos('[lay', valueText) <> 0) then
    begin
      ledInd.FnToken := ifLayer;
      if (pos('[layd]', valueText) <> 0) then
        ledInd.LayerIdx := LAYER_BASE_360
      else if (pos('[layk]', valueText) <> 0) then
        ledInd.LayerIdx := LAYER_KEYPAD_360
      else if (pos('[lay1]', valueText) <> 0) then
        ledInd.LayerIdx := LAYER_FN1_360
      else if (pos('[lay2]', valueText) <> 0) then
        ledInd.LayerIdx := LAYER_FN2_360
      else if (pos('[lay3]', valueText) <> 0) then
        ledInd.LayerIdx := LAYER_FN3_360;
      Delete(valueText, 1, 6);
    end;
  end;
begin
  ResetLedOptions;

  try
    lineCount := aLedContent.Count;

    for i := 0 to lineCount - 1 do
    begin
      if (aLedContent.Count > i) then
      begin
        currentLine := AnsiLowerCase(aLedContent.Strings[i]);
        posSep := Pos('>', currentLine);

        //Check if it's a valid line
        if (posSep <> 0) then
        begin
          configText := Copy(currentLine, 1, posSep - 1);
          valueText := Copy(currentLine, posSep + 1, Length(currentLine));
          ledInd := nil;

          if (pos('ind1', configText) <> 0) then
            ledInd := FLedIndicators[0]
          else if (pos('ind2', configText) <> 0) then
            ledInd := FLedIndicators[1]
          else if (pos('ind3', configText) <> 0) then
            ledInd := FLedIndicators[2]
          else if (pos('ind4', configText) <> 0) then
            ledInd := FLedIndicators[3]
          else if (pos('ind5', configText) <> 0) then
            ledInd := FLedIndicators[4]
          else if (pos('ind6', configText) <> 0) then
            ledInd := FLedIndicators[5];

          if (ledInd <> nil) then
          begin
            GetFunctionToken(valueText);
            if (ledInd.FnToken <> ifDisable) and (ledInd.FnToken <> ifBattery) then
               ledInd.IndColor[ledInd.LayerIdx] := RGBStringToColor(valueText, DEFAULT_LED_COLOR_BASE);
          end;
        end;
      end;
    end;
  finally

  end;
end;

procedure TKeyService.ConvertEdgeFromTextFileFmt(
  aEdgeContent: TStringList);
var
  aKey: TKey;
  sKey: string;
  keyStart, keyEnd: integer;
  i: integer;
  currentLine: string;
  secondLine: string;
  posSep: integer;
  isSingleKey: boolean;
  configText: string;
  valueText: string;
  aKBKey: TKBKey;
  lineCount: integer;
  isKeypadLayer: boolean;
  aEdgeMode: TLedMode;
  layerIdx: integer;
  aColor: TColor;
  aEdgeTopLayer: TStringList;
  aEdgeBotLayer: TStringList;
  keyExcept: TKey;
begin
  ResetEdgeOptions;

  try
    aEdgeTopLayer := TStringList.Create;
    aEdgeBotLayer := TStringList.Create;

    //Split content in 2 string lists
    if (aEdgeContent.Count > 0) then
    begin
      for i:= 0 to aEdgeContent.Count - 1 do
      begin
        currentLine := TrimRight(AnsiLowerCase(aEdgeContent.Strings[i]));
        if (Pos(KEYPAD_KEY_EDGE, currentLine) <> 0) then
          aEdgeBotLayer.Add(currentLine)
        else
          aEdgeTopLayer.Add(currentLine);
      end;
    end;

    //2 passes, first for top layer then bottom layer
    for layerIdx := TOPLAYER_IDX to BOTLAYER_IDX do
    begin
      if (layerIdx = TOPLAYER_IDX) then
        aEdgeContent := aEdgeTopLayer
      else
        aEdgeContent := aEdgeBotLayer;

      lineCount := aEdgeContent.Count;
      if (lineCount > 0) then
      begin
        //First line is led mode
        currentLine := TrimRight(AnsiLowerCase(aEdgeContent.Strings[0]));
        secondLine := '';
        if (lineCount > 1) then
          secondLine := TrimRight(AnsiLowerCase(aEdgeContent.Strings[1]));

        if (layerIdx = BOTLAYER_IDX) then
          Delete(currentLine, 1, length(KEYPAD_KEY_EDGE)); //removes fn text

        //Mono only if 1 line, else it's freestyle with mono option
        if (pos(EDGE_MONO, currentLine) > 0) and (lineCount = 1) then
        begin
          aEdgeMode := lmMonochrome;
          lineCount := 1;
        end
        else if (pos(EDGE_BREATHE, currentLine) > 0) THEN
          aEdgeMode := lmBreathe
        else if (pos(EDGE_SPECTRUM, currentLine) > 0) THEN
        begin
          aEdgeMode := lmSpectrum;
          lineCount := 1;
        end
        else if (pos(EDGE_WAVE, currentLine) > 0) THEN
        begin
          aEdgeMode := lmWave;
          lineCount := 1;
        end
        else if (pos(EDGE_FROZENWAVE, currentLine) > 0) THEN
        begin
          aEdgeMode := lmFrozenWave;
        end
        else if (pos(EDGE_REBOUND, currentLine) > 0) or (pos(EDGE_REBOUND, secondLine) > 0) THEN
        begin
          aEdgeMode := lmRebound;
          lineCount := 2;
        end
        else if (pos(EDGE_LOOP, currentLine) > 0) or (pos(EDGE_LOOP, secondLine) > 0) THEN
        begin
          aEdgeMode := lmLoop;
          lineCount := 2;
        end
        else if (pos(EDGE_PULSE, currentLine) > 0) THEN
        begin
          aEdgeMode := lmPulse;
          lineCount := 1;
        end
        else if (currentLine = '') then
          aEdgeMode := lmDisabled
        else
          aEdgeMode := lmFreestyle;

        if (layerIdx = BOTLAYER_IDX) then
          FEdgeModeFn := aEdgeMode
        else
          FEdgeMode := aEdgeMode;

        for i := 0 to lineCount - 1 do
        begin
          if (aEdgeContent.Count > i) then
          begin
            currentLine := AnsiLowerCase(aEdgeContent.Strings[i]);
            if (currentLine <> '') then
            begin
              //Check if it's keypad layer
              if (layerIdx = BOTLAYER_IDX) then
                Delete(currentLine, 1, length(KEYPAD_KEY_EDGE)); //removes fn text

              //Reset values
              aKBKey := nil;

              posSep := Pos('>', currentLine);
              isSingleKey := Copy(currentLine, 1, 1) = SK_START;

              //Check if it's a valid line
              if (posSep <> 0) and (isSingleKey) then
              begin
                configText := Copy(currentLine, 1, posSep - 1);
                valueText := Copy(currentLine, posSep + 1, Length(currentLine));

                if (aEdgeMode = lmFreestyle) or ((i > 0) and (aEdgeMode in [lmBreathe, lmFrozenWave])) then
                begin
                  //If mono tag, then set color for all keys
                  if (pos(EDGE_MONO, currentLine) > 0) then
                  begin
                    SetAllKeyColorEdge(RGBStringToColor(valueText, clNone), layerIdx);
                  end
                  else
                  begin
                    //Load configured key
                    keyStart := Pos(SK_START, configText);
                    keyEnd := Pos(SK_END, configText);
                    sKey := Copy(configText, keyStart + 1, keyEnd - 2);

                    aKey := FindKeyConfig(sKey);

                    //Gets key from top layer
                    if aKey <> nil then
                    begin
                      keyExcept := GetKeyLoadException(aKey.Key, layerIdx);
                      if (keyExcept <> nil) then
                        aKBKey := GetEdgeKey(keyExcept.Key, layerIdx)
                      else
                        aKBKey := GetEdgeKey(aKey.Key, layerIdx);
                    end;
                  end;
                end;

                if (aKBKey <> nil) and (aEdgeMode in [lmFreestyle, lmBreathe, lmFrozenWave]) then
                begin
                  aKBKey.KeyColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                end
                else if (aEdgeMode = lmBreathe) and (i = 0) then
                begin
                  if (layerIdx = BOTLAYER_IDX) then
                    FEdgeSpeedFn := GetLedSpeedFile(valueText)
                  else
                    FEdgeSpeed := GetLedSpeedFile(valueText);
                end
                else if (aEdgeMode in [lmRebound, lmLoop]) and (i = 0) then //Mono first line
                begin
                  if (pos(EDGE_MONO, currentLine) > 0) then
                  begin
                    aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR_BASE);
                    case aEdgeMode of
                      lmRebound:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseEdgeColorReboundFn := aColor
                        else
                          FBaseEdgeColorRebound := aColor;
                      end;
                      lmLoop:
                      begin
                        if (layerIdx = BOTLAYER_IDX) then
                          FBaseEdgeColorLoopFn := aColor
                        else
                          FBaseEdgeColorLoop := aColor;
                      end;
                    end;
                  end;
                end
                else if (aEdgeMode = lmMonochrome) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                    FEdgeColorMonoFn := aColor
                  else
                    FEdgeColorMono := aColor;
                end
                else if (aEdgeMode in [lmSpectrum]) then
                begin
                  if (layerIdx = BOTLAYER_IDX) then
                    FEdgeSpeedFn := GetLedSpeedFile(valueText)
                  else
                    FEdgeSpeed := GetLedSpeedFile(valueText);
                end
                else if (aEdgeMode = lmWave) then
                begin
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FEdgeSpeedFn := GetLedSpeedFile(valueText);
                    FEdgeDirectionFn := GetLedDirectionFile(valueText);
                    if not(FEdgeDirectionFn in [LED_DIR_LEFT_INT, LED_DIR_RIGHT_INT]) then
                      FEdgeDirectionFn := LED_DIR_LEFT_INT;
                  end
                  else
                  begin
                    FEdgeSpeed := GetLedSpeedFile(valueText);
                    FEdgeDirection := GetLedDirectionFile(valueText);
                    if not(FEdgeDirection in [LED_DIR_LEFT_INT, LED_DIR_RIGHT_INT]) then
                      FEdgeDirection := LED_DIR_LEFT_INT;
                  end;
                end
                else if (aEdgeMode = lmRebound) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FEdgeColorReboundFn := aColor;
                    FEdgeSpeedFn := GetLedSpeedFile(valueText);
                  end
                  else
                  begin
                    FEdgeColorRebound := aColor;
                    FEdgeSpeed := GetLedSpeedFile(valueText);
                  end;
                end
                else if (aEdgeMode = lmLoop) then
                begin
                  aColor := RGBStringToColor(valueText, DEFAULT_LED_COLOR);
                  if (layerIdx = BOTLAYER_IDX) then
                  begin
                    FEdgeColorLoopFn := aColor;
                    FEdgeSpeedFn := GetLedSpeedFile(valueText);
                    FEdgeDirectionFn := GetLedDirectionFile(valueText);
                    if not(FEdgeDirectionFn in [LED_DIR_LEFT_INT, LED_DIR_RIGHT_INT]) then
                      FEdgeDirectionFn := LED_DIR_LEFT_INT;
                  end
                  else
                  begin
                    FEdgeColorLoop := aColor;
                    FEdgeSpeed := GetLedSpeedFile(valueText);
                    FEdgeDirection := GetLedDirectionFile(valueText);
                    if not(FEdgeDirection in [LED_DIR_LEFT_INT, LED_DIR_RIGHT_INT]) then
                      FEdgeDirection := LED_DIR_LEFT_INT;
                  end;
                end
                else if (aEdgeMode = lmPulse) then
                begin
                  if (layerIdx = BOTLAYER_IDX) then
                    FEdgeSpeedFn := GetLedSpeedFile(valueText)
                  else
                    FEdgeSpeed := GetLedSpeedFile(valueText);
                end
              end;
            end;
          end;
        end;
      end;
    end;
  finally
    if (aEdgeTopLayer <> nil) then
      FreeAndNil(aEdgeTopLayer);
    if (aEdgeBotLayer <> nil) then
      FreeAndNil(aEdgeBotLayer);
  end;
end;

function TKeyService.ExtractEdgeFromTextFile(var aLedContent: TStringList
  ): TStringList;
var
  aEdgeContent: TStringList;
  i: integer;
  currentLine: string;
  aToDelete: array of integer;
begin
  aEdgeContent := TStringList.Create;
  SetLength(aToDelete, 0);

  try
    if (aLedContent <> nil) and (aLedContent.Count > 0) then
    begin
      for i:= 0 to aLedContent.Count -1 do
      begin
        currentLine := TrimRight(AnsiLowerCase(aLedContent.Strings[i]));
        if (IsEdgeSyntax(currentLine)) then
        begin
          aEdgeContent.Add(currentLine);

          SetLength(aToDelete, length(aToDelete) + 1);
          aToDelete[High(aToDelete)] := i;
        end;
      end;

      for i := length(aToDelete) - 1 downto 0 do
      begin
        aLedContent.Delete(aToDelete[i]);
      end;
    end;
  finally
  end;
  result := aEdgeContent;
end;

function TKeyService.IsEdgeSyntax(value: string): boolean;
var
  i: integer;
begin
  result := false;

  if (Pos(KEYPAD_KEY_EDGE, value) <> 0) then
    Delete(value, 1, length(KEYPAD_KEY_EDGE)); //removes fn text

  for i := 1 to 30 do
  begin
    result := result or
      value.StartsWith('[l' + IntToStr(i) + ']') or
      value.StartsWith('[r' + IntToStr(i) + ']') or
      value.StartsWith('[b' + IntToStr(i) + ']');
  end;

  result := result or
    value.StartsWith(EDGE_MONO) or
    value.StartsWith(EDGE_BREATHE) or
    value.StartsWith(EDGE_SPECTRUM) or
    value.StartsWith(EDGE_WAVE) or
    value.StartsWith(EDGE_FROZENWAVE) or
    value.StartsWith(EDGE_REBOUND) or
    value.StartsWith(EDGE_LOOP) or
    value.StartsWith(EDGE_PULSE);
end;

//Checks if value is a keypad exception (Adv2)
function TKeyService.KeyPadException(value: string): boolean;
begin
  result := (value = 'menu') or
    (value = 'play') or
    (value = 'prev') or
    (value = 'next') or
    (value = 'calc') or
    (value = 'kpshft') or
    (value = 'mute') or
    (value = 'vol-') or
    (value = 'vol+') or
    (value = 'kp0') or (value = 'kp1') or (value = 'kp2') or
    (value = 'kp3') or (value = 'kp4') or (value = 'kp5') or
    (value = 'kp6') or (value = 'kp7') or (value = 'kp8') or (value = 'kp9') or
    (value = 'numlk') or
    (value = 'kp=') or
    (value = 'kpdiv') or
    (value = 'kpmult') or
    (value = 'kpmin') or
    (value = 'kpplus') or
    (value = 'kpenter1') or (value = 'kpenter2') or
    (value = 'kp.')  or
    (value = 'kp-insert');
end;

//Checks if value is a keypad exception (Adv2)
function TKeyService.GetKeyPadException(value: string): integer;
begin
  case value of
    'menu': result := VK_KP_MENU;
    'play': result := VK_KP_PLAY;
    'prev': result := VK_KP_PREV;
    'next': result := VK_KP_NEXT;
    'calc': result := VK_KP_CALC;
    'kpshft': result := VK_KP_KPSHIFT;
    'mute': result := VK_KP_MUTE;
    'vol-': result := VK_KP_VOLDOWN;
    'vol+': result := VK_KP_VOLUP;
    'numlk': result := VK_KP_NUMLCK;
    'kp=': result := VK_KP_EQUAL;
    'kpdiv': result := VK_KP_DIVIDE;
    'kpmult': result := VK_KP_MULT;
    'kp0': result := VK_KP_0;
    'kp1': result := VK_KP_1;
    'kp2': result := VK_KP_2;
    'kp3': result := VK_KP_3;
    'kp4': result := VK_KP_4;
    'kp5': result := VK_KP_5;
    'kp6': result := VK_KP_6;
    'kp7': result := VK_KP_7;
    'kp8': result := VK_KP_8;
    'kp9': result := VK_KP_9;
    'kpmin': result := VK_KP_MIN;
    'kpplus': result := VK_KP_PLUS;
    'kpenter1': result := VK_KP_ENTER1;
    'kpenter2': result := VK_KP_ENTER2;
    'kp.': result := VK_KP_PERI;
    'insert': result := VK_INSERT;
    else
      result := -1;
  end;
end;

procedure TKeyService.InitGifsRGB;
var
  gifFrame: TGifFrame;
  idx: integer;
begin
  FRainGif := TGif.Create;
  FReactiveGif := TGif.Create;
  FRippleGif := TGif.Create;
  FFireballGif := TGif.Create;
  FLoopDownGif := TGif.Create;
  FLoopUpGif := TGif.Create;
  FLoopLeftGif := TGif.Create;
  FLoopRightGif := TGif.Create;
  FReboundHorGif := TGif.Create;
  FReboundVerGif := TGif.Create;
  FstarlightGif := TGif.Create;

  //Rain Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(67);
  gifFrame.Keys.Add(88);
  RainGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(66);
  gifFrame.Keys.Add(83);
  RainGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(82);
  RainGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(87);
  gifFrame.Keys.Add(94);
  RainGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(90);
  RainGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(86);
  gifFrame.Keys.Add(89);
  gifFrame.Keys.Add(91);
  RainGif.Add(gifFrame);
  //End Rain Gif

  //Reactive Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  ReactiveGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(45);
  ReactiveGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(45);
  ReactiveGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(71);
  ReactiveGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(73);
  ReactiveGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(73);
  ReactiveGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(73);
  ReactiveGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(73);
  ReactiveGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(73);
  ReactiveGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 15
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 16
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 17
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 18
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  ReactiveGif.Add(gifFrame);

  //Frame 19
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(74);
  ReactiveGif.Add(gifFrame);

  //Frame 20
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(74);
  ReactiveGif.Add(gifFrame);

  //Frame 21
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(74);
  ReactiveGif.Add(gifFrame);

  //Frame 22
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(61);
  ReactiveGif.Add(gifFrame);

  //Frame 23
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(61);
  ReactiveGif.Add(gifFrame);

  //Frame 24
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(61);
  ReactiveGif.Add(gifFrame);
  //End Reactive Gif

  //Ripple Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(55);
  RippleGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(71);
  RippleGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(86);
  gifFrame.Keys.Add(87);
  RippleGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(68);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(84);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(88);
  RippleGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(65);
  gifFrame.Keys.Add(67);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(77);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(83);
  RippleGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(66);
  gifFrame.Keys.Add(76);
  gifFrame.Keys.Add(81);
  gifFrame.Keys.Add(82);
  gifFrame.Keys.Add(90);
  gifFrame.Keys.Add(91);
  gifFrame.Keys.Add(92);
  RippleGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(89);
  gifFrame.Keys.Add(93);
  gifFrame.Keys.Add(94);
  RippleGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  RippleGif.Add(gifFrame);
  //End Ripple Gif

  //Fireball Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(19);
  FireballGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(89);
  FireballGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(90);
  FireballGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(91);
  FireballGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(92);
  FireballGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(93);
  FireballGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(94);
  FireballGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(57);
  FireballGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(58);
  FireballGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(48);
  FireballGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(49);
  FireballGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(50);
  FireballGif.Add(gifFrame);
  //End Fireball Gif

  //Loop Down Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  for idx := 0 to 16 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  for idx := 0 to 33 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  for idx := 17 to 50 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  for idx := 34 to 66 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  for idx := 51 to 82 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  for idx := 67 to 94 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);
  //End Loop Down Gif

  //Loop Up Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  for idx := 83 to 94 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  for idx := 67 to 94 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  for idx := 51 to 82 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  for idx := 34 to 66 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  for idx := 17 to 50 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  for idx := 0 to 33 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);
  //End Loop Up Gif

  //Loop Left Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(66);
  gifFrame.Keys.Add(82);
  gifFrame.Keys.Add(94);
  LoopLeftGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(66);
  gifFrame.Keys.Add(82);
  gifFrame.Keys.Add(94);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(65);
  gifFrame.Keys.Add(81);
  gifFrame.Keys.Add(93);
  LoopLeftGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(65);
  gifFrame.Keys.Add(81);
  gifFrame.Keys.Add(93);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(92);
  LoopLeftGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(92);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(91);
  LoopLeftGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(91);
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(90);
  LoopLeftGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(90);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(77);
  LoopLeftGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(77);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(76);
  LoopLeftGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(76);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(89);
  LoopLeftGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(89);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(74);
  LoopLeftGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(88);
  LoopLeftGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(88);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(72);
  LoopLeftGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(71);
  LoopLeftGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(87);
  LoopLeftGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(86);
  gifFrame.Keys.Add(87);
  LoopLeftGif.Add(gifFrame);

  //Frame 15
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(68);
  gifFrame.Keys.Add(84);
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(86);
  LoopLeftGif.Add(gifFrame);

  //Frame 16
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(67);
  gifFrame.Keys.Add(83);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(68);
  gifFrame.Keys.Add(84);
  LoopLeftGif.Add(gifFrame);

  //Frame 17
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(67);
  gifFrame.Keys.Add(83);
  LoopLeftGif.Add(gifFrame);
  //End Loop Left Gif

  //Loop Right Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(67);
  gifFrame.Keys.Add(83);
  LoopRightGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(67);
  gifFrame.Keys.Add(83);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(68);
  gifFrame.Keys.Add(84);
  LoopRightGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(68);
  gifFrame.Keys.Add(84);
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(86);
  LoopRightGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(86);
  gifFrame.Keys.Add(87);
  LoopRightGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(87);
  LoopRightGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(71);
  LoopRightGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(88);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(72);
  LoopRightGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(88);
  LoopRightGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(89);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(74);
  LoopRightGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(76);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(89);
  LoopRightGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(77);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(76);
  LoopRightGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(90);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(77);
  LoopRightGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(91);
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(90);
  LoopRightGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(92);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(91);
  LoopRightGif.Add(gifFrame);

  //Frame 15
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(65);
  gifFrame.Keys.Add(81);
  gifFrame.Keys.Add(93);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(92);
  LoopRightGif.Add(gifFrame);

  //Frame 16
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(66);
  gifFrame.Keys.Add(82);
  gifFrame.Keys.Add(94);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(65);
  gifFrame.Keys.Add(81);
  gifFrame.Keys.Add(93);
  LoopRightGif.Add(gifFrame);

  //Frame 17
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(66);
  gifFrame.Keys.Add(82);
  gifFrame.Keys.Add(94);
  LoopRightGif.Add(gifFrame);
  //End Loop Right Gif

  //Rebound Horizontal Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(67);
  gifFrame.Keys.Add(68);
  gifFrame.Keys.Add(83);
  gifFrame.Keys.Add(84);
  ReboundHorGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(68);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(84);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(86);
  ReboundHorGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(86);
  gifFrame.Keys.Add(87);
  ReboundHorGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(87);
  ReboundHorGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(72);
  ReboundHorGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(88);
  ReboundHorGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(88);
  ReboundHorGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(89);
  ReboundHorGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(76);
  gifFrame.Keys.Add(89);
  ReboundHorGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(76);
  gifFrame.Keys.Add(77);
  ReboundHorGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(77);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(90);
  ReboundHorGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(90);
  gifFrame.Keys.Add(91);
  ReboundHorGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(91);
  gifFrame.Keys.Add(92);
  ReboundHorGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(65);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(81);
  gifFrame.Keys.Add(92);
  gifFrame.Keys.Add(93);
  ReboundHorGif.Add(gifFrame);

  //Frame 15
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(66);
  gifFrame.Keys.Add(82);
  gifFrame.Keys.Add(94);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(65);
  gifFrame.Keys.Add(81);
  gifFrame.Keys.Add(93);
  ReboundHorGif.Add(gifFrame);

  //Frame 16
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(65);
  gifFrame.Keys.Add(81);
  gifFrame.Keys.Add(93);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(92);
  ReboundHorGif.Add(gifFrame);

  //Frame 17
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(64);
  gifFrame.Keys.Add(80);
  gifFrame.Keys.Add(92);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(91);
  ReboundHorGif.Add(gifFrame);

  //Frame 18
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(63);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(91);
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(90);
  ReboundHorGif.Add(gifFrame);

  //Frame 19
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(78);
  gifFrame.Keys.Add(90);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(77);
  ReboundHorGif.Add(gifFrame);

  //Frame 20
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(61);
  gifFrame.Keys.Add(77);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(76);
  ReboundHorGif.Add(gifFrame);

  //Frame 21
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(76);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(89);
  ReboundHorGif.Add(gifFrame);

  //Frame 22
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(59);
  gifFrame.Keys.Add(75);
  gifFrame.Keys.Add(89);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(74);
  ReboundHorGif.Add(gifFrame);

  //Frame 23
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(58);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(88);
  ReboundHorGif.Add(gifFrame);

  //Frame 24
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(88);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(72);
  ReboundHorGif.Add(gifFrame);

  //Frame 25
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(72);
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(71);
  ReboundHorGif.Add(gifFrame);

  //Frame 26
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(71);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(87);
  ReboundHorGif.Add(gifFrame);

  //Frame 27
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(86);
  gifFrame.Keys.Add(87);
  ReboundHorGif.Add(gifFrame);

  //Frame 28
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(68);
  gifFrame.Keys.Add(84);
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(69);
  gifFrame.Keys.Add(85);
  gifFrame.Keys.Add(86);
  ReboundHorGif.Add(gifFrame);

  //End Rebound Horizontal Gif

  //Rebound Vertical Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  for idx := 0 to 33 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  for idx := 17 to 50 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  for idx := 34 to 66 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  for idx := 51 to 82 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  for idx := 67 to 94 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  for idx := 51 to 82 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  for idx := 34 to 66 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  for idx := 17 to 50 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);
  //End Rebound Vertical Gif

  //Starlight Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(73);
  starlightGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  //gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(37); //
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(73);
  starlightGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(15); //
  //gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(73);
  starlightGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(28);
  //gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(70); //
  gifFrame.Keys.Add(73);
  starlightGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1); //
  //gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(73);
  starlightGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(13); //
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(43);
  //gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(73);
  starlightGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(41); //
  gifFrame.Keys.Add(43);
  //gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(73);
  starlightGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(41);
  //gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(85); //
  starlightGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(21); //
  gifFrame.Keys.Add(28);
  //gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(62); //
  gifFrame.Keys.Add(70);
  //gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(21);
  //gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(79); //
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(21);
  //gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(74); //
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(8); //
  gifFrame.Keys.Add(13);
  //gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(19); //
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(62);
  //gifFrame.Keys.Add(70);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 15
  gifFrame := TGifFrame.Create;
  //gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(32); //
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 16
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2); //
  gifFrame.Keys.Add(8);
  //gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 17
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(32);
  //gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(45); //
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 18
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53); //
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  //gifFrame.Keys.Add(85);
  starlightGif.Add(gifFrame);

  //Frame 19
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(19);
  //gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(34); //
  gifFrame.Keys.Add(43); //
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  starlightGif.Add(gifFrame);

  //Frame 20
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  //gifFrame.Keys.Add(62);
  gifFrame.Keys.Add(73); //
  gifFrame.Keys.Add(74);
  gifFrame.Keys.Add(79);
  starlightGif.Add(gifFrame);

  //Frame 21
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(28); //
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(73);
  gifFrame.Keys.Add(74);
  //gifFrame.Keys.Add(79);
  starlightGif.Add(gifFrame);

  //End Starlight Gif
end;

procedure TKeyService.InitGifsTKO;
var
  gifFrame: TGifFrame;
  idx: integer;
begin
  FRainGif := TGif.Create;
  FReactiveGif := TGif.Create;
  FRippleGif := TGif.Create;
  FFireballLeftGif := TGif.Create;
  FFireballRightGif := TGif.Create;
  FLoopDownGif := TGif.Create;
  FLoopUpGif := TGif.Create;
  FLoopLeftGif := TGif.Create;
  FLoopRightGif := TGif.Create;
  FReboundHorGif := TGif.Create;
  FReboundVerGif := TGif.Create;
  FStarlightGif := TGif.Create;
  FEdgeLoopLeftGif := TGif.Create;
  FEdgeLoopRightGif := TGif.Create;
  FEdgeReboundGif := TGif.Create;

  //Rain Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  RainGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(15);
  RainGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(29);
  RainGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(42);
  RainGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(55);
  RainGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(61);
  RainGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(57);
  gifFrame.Keys.Add(58);
  RainGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(56);
  RainGif.Add(gifFrame);
  //End Rain Gif

  //Reactive Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  ReactiveGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(48);
  ReactiveGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(48);
  ReactiveGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(48);
  ReactiveGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(58);
  ReactiveGif.Add(gifFrame);

  //Frame 15
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(56);
  ReactiveGif.Add(gifFrame);

  //Frame 16
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(56);
  ReactiveGif.Add(gifFrame);

  //Frame 17
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(56);
  ReactiveGif.Add(gifFrame);

  //Frame 18
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(56);
  ReactiveGif.Add(gifFrame);

  //Frame 19
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(56);
  ReactiveGif.Add(gifFrame);

  //Frame 20
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(46);
  ReactiveGif.Add(gifFrame);

  //Frame 21
  gifFrame := TGifFrame.Create;
  ReactiveGif.Add(gifFrame);
  //End Reactive Gif

  //Ripple Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  RippleGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(34);
  RippleGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(57);
  RippleGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(56);
  gifFrame.Keys.Add(58);
  RippleGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(55);
  gifFrame.Keys.Add(59);
  RippleGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(54);
  gifFrame.Keys.Add(60);
  RippleGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(61);
  RippleGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(62);
  RippleGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  RippleGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  RippleGif.Add(gifFrame);
  //End Ripple Gif

  //Fireball Left Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  FFireballLeftGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(47);
  FFireballLeftGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(46);
  FFireballLeftGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(45);
  FFireballLeftGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(44);
  FFireballLeftGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(43);
  FFireballLeftGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(42);
  FFireballLeftGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(41);
  FFireballLeftGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(30);
  FFireballLeftGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(29);
  FFireballLeftGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(28);
  FFireballLeftGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  FFireballLeftGif.Add(gifFrame);
  //End Fireball Left Gif

  //Fireball Right Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(34);
  FFireballRightGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(35);
  FFireballRightGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(36);
  FFireballRightGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(47);
  FFireballRightGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(48);
  FFireballRightGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(49);
  FFireballRightGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(51);
  FFireballRightGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(52);
  FFireballRightGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(24);
  FFireballRightGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(25);
  FFireballRightGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(26);
  FFireballRightGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(27);
  FFireballRightGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  FFireballRightGif.Add(gifFrame);
  //End Fireball Right Gif

  //Loop Down Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  for idx := 0 to 13 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  for idx := 0 to 13 do
    gifFrame.Keys.Add(idx);
  for idx := 14 to 27 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  for idx := 14 to 27 do
    gifFrame.Keys.Add(idx);
  for idx := 28 to 40 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  for idx := 28 to 40 do
    gifFrame.Keys.Add(idx);
  for idx := 41 to 52 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  for idx := 41 to 52 do
    gifFrame.Keys.Add(idx);
  for idx := 53 to 62 do
    gifFrame.Keys.Add(idx);
  LoopDownGif.Add(gifFrame);
  //End Loop Down Gif

  //Loop Up Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  for idx := 53 to 62 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  for idx := 41 to 52 do
    gifFrame.Keys.Add(idx);
  for idx := 53 to 62 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  for idx := 28 to 40 do
    gifFrame.Keys.Add(idx);
  for idx := 41 to 52 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  for idx := 14 to 27 do
    gifFrame.Keys.Add(idx);
  for idx := 28 to 40 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  for idx := 0 to 13 do
    gifFrame.Keys.Add(idx);
  for idx := 14 to 27 do
    gifFrame.Keys.Add(idx);
  LoopUpGif.Add(gifFrame);
  //End Loop Up Gif

  //Loop Left Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(62);
  LoopLeftGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(61);
  LoopLeftGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(59);
  LoopLeftGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(58);
  LoopLeftGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(57);
  LoopLeftGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(56);
  LoopLeftGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(55);
  LoopLeftGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(54);
  LoopLeftGif.Add(gifFrame);
  //End Loop Left Gif

  //Loop Right Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(54);
  LoopRightGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(55);
  LoopRightGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(56);
  LoopRightGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(57);
  LoopRightGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(58);
  LoopRightGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(59);
  LoopRightGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(61);
  LoopRightGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(62);
  LoopRightGif.Add(gifFrame);
  //End Loop Right Gif

  //Rebound Horizontal Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  gifFrame.Keys.Add(27);
  gifFrame.Keys.Add(40);
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(62);
  ReboundHorGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(61);
  ReboundHorGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(59);
  ReboundHorGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(58);
  ReboundHorGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(57);
  ReboundHorGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(56);
  ReboundHorGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(55);
  ReboundHorGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  gifFrame.Keys.Add(1);
  gifFrame.Keys.Add(14);
  gifFrame.Keys.Add(28);
  gifFrame.Keys.Add(41);
  gifFrame.Keys.Add(53);
  gifFrame.Keys.Add(54);
  ReboundHorGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  gifFrame.Keys.Add(3);
  gifFrame.Keys.Add(15);
  gifFrame.Keys.Add(16);
  gifFrame.Keys.Add(29);
  gifFrame.Keys.Add(30);
  gifFrame.Keys.Add(42);
  gifFrame.Keys.Add(43);
  gifFrame.Keys.Add(55);
  ReboundHorGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  gifFrame.Keys.Add(5);
  gifFrame.Keys.Add(17);
  gifFrame.Keys.Add(18);
  gifFrame.Keys.Add(31);
  gifFrame.Keys.Add(32);
  gifFrame.Keys.Add(44);
  gifFrame.Keys.Add(45);
  gifFrame.Keys.Add(56);
  ReboundHorGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  gifFrame.Keys.Add(7);
  gifFrame.Keys.Add(19);
  gifFrame.Keys.Add(20);
  gifFrame.Keys.Add(33);
  gifFrame.Keys.Add(34);
  gifFrame.Keys.Add(46);
  gifFrame.Keys.Add(47);
  gifFrame.Keys.Add(57);
  ReboundHorGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  gifFrame.Keys.Add(9);
  gifFrame.Keys.Add(21);
  gifFrame.Keys.Add(22);
  gifFrame.Keys.Add(35);
  gifFrame.Keys.Add(36);
  gifFrame.Keys.Add(48);
  gifFrame.Keys.Add(58);
  ReboundHorGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  gifFrame.Keys.Add(11);
  gifFrame.Keys.Add(23);
  gifFrame.Keys.Add(24);
  gifFrame.Keys.Add(37);
  gifFrame.Keys.Add(38);
  gifFrame.Keys.Add(49);
  gifFrame.Keys.Add(50);
  gifFrame.Keys.Add(59);
  ReboundHorGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  gifFrame.Keys.Add(25);
  gifFrame.Keys.Add(26);
  gifFrame.Keys.Add(39);
  gifFrame.Keys.Add(51);
  gifFrame.Keys.Add(60);
  gifFrame.Keys.Add(61);
  ReboundHorGif.Add(gifFrame);

  //End Rebound Horizontal Gif

  //Rebound Vertical Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  for idx := 53 to 62 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 41 to 52 do
    gifFrame.Keys.Add(idx);
  for idx := 53 to 62 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 28 to 40 do
    gifFrame.Keys.Add(idx);
  for idx := 41 to 52 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 14 to 27 do
    gifFrame.Keys.Add(idx);
  for idx := 28 to 40 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 0 to 13 do
    gifFrame.Keys.Add(idx);
  for idx := 14 to 27 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 0 to 13 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 0 to 13 do
    gifFrame.Keys.Add(idx);
  for idx := 14 to 27 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 14 to 27 do
    gifFrame.Keys.Add(idx);
  for idx := 28 to 40 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 28 to 40 do
    gifFrame.Keys.Add(idx);
  for idx := 41 to 52 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);

  gifFrame := TGifFrame.Create;
  for idx := 41 to 52 do
    gifFrame.Keys.Add(idx);
  for idx := 53 to 62 do
    gifFrame.Keys.Add(idx);
  ReboundVerGif.Add(gifFrame);
  //End Rebound Vertical Gif

  //Starlight Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(54);
  starlightGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  starlightGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(51);
  starlightGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  starlightGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(28);
  starlightGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(61);
  starlightGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(44);
  starlightGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  starlightGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(33);
  starlightGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(52);
  gifFrame.Keys.Add(54);
  starlightGif.Add(gifFrame);
  //End Starlight Gif

  //Loop Edge Left Gif
  //Frame 1
  gifFrame := TGifFrame.Create;
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(22);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(21);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(19);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(18);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(17);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(16);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(15);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(14);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(11);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 15
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 16
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(9);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 17
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 18
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(7);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 19
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 20
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(5);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 21
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 22
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(3);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 23
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 24
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 25
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 26
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(32);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 27
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(31);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 28
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(30);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 29
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(29);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 30
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(28);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 31
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(27);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 32
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(26);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 33
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(25);
  EdgeLoopLeftGif.Add(gifFrame);

  //Frame 34
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(24);
  EdgeLoopLeftGif.Add(gifFrame);
  //End Edge Loop Left Gif

  //Loop Edge Right Gif

  //Frame 1
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(24);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 2
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(25);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 3
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(26);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 4
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(27);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 5
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(28);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 6
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(29);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 7
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(30);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 8
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(31);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 9
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(32);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 10
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(0);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 11
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(1);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 12
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(2);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 13
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(3);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 14
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(4);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 15
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(5);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 16
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(6);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 17
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(7);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 18
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(8);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 19
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(9);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 20
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(10);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 21
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(11);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 22
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(12);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 23
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(13);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 24
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(14);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 25
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(15);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 26
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(16);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 27
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(17);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 28
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(18);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 29
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(19);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 30
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(20);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 31
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(21);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 32
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(22);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 33
  gifFrame := TGifFrame.Create;
  gifFrame.Keys.Add(23);
  EdgeLoopRightGif.Add(gifFrame);

  //Frame 34
  gifFrame := TGifFrame.Create;
  EdgeLoopRightGif.Add(gifFrame);

  //End Edge Loop Right Gif

  //Edge Rebound Gif
  for idx := 23 downto 0 do
  begin
    gifFrame := TGifFrame.Create;
    gifFrame.Keys.Add(idx);
    EdgeReboundGif.Add(gifFrame);
  end;

  for idx := 1 to 32 do
  begin
    gifFrame := TGifFrame.Create;
    gifFrame.Keys.Add(idx);
    EdgeReboundGif.Add(gifFrame);
  end;

  for idx := 31 downto 24 do
  begin
    gifFrame := TGifFrame.Create;
    gifFrame.Keys.Add(idx);
    EdgeReboundGif.Add(gifFrame);
  end;
  //End Edge Rebound Gif
end;

function TKeyService.GetLedMode: TLedMode;
begin
  result := FLedMode;
  if (ConfigMode = CONFIG_EDGE_LIGHTING) then
    result := FEdgeMode;

  if (ActiveLayer <> nil) and (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
  begin
    result := FLedModeFn;
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      result := FEdgeModeFn;
  end;
end;

procedure TKeyService.SetLedMode(aLedMode: TLedMode);
begin
  if (ActiveLayer = nil) or (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeMode := aLedMode
    else
      FLedMode := aLedMode;
  end
  else
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeModeFn := aLedMode
    else
      FLedModeFn := aLedMode;
  end;
end;

function TKeyService.GetLedSpeed: integer;
begin
  result := FLedSpeed;
  if (ConfigMode = CONFIG_EDGE_LIGHTING) then
    result := FEdgeSpeed;

  if (ActiveLayer <> nil) and (ActiveLayer.LayerIndex = BOTLAYER_IDX)then
  begin
    result := FLedSpeedFn;
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      result := FEdgeSpeedFn;
  end;
end;

procedure TKeyService.SetLedSpeed(aLedSpeed: integer);
begin
  if (ActiveLayer = nil) or (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeSpeed := aLedSpeed
    else
      FLedSpeed := aLedSpeed;
  end
  else
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeSpeedFn := aLedSpeed
    else
      FLedSpeedFn := aLedSpeed;
  end;
end;

function TKeyService.GetLedDirection: integer;
begin
  result := FLedDirection;
  if (ConfigMode = CONFIG_EDGE_LIGHTING) then
    result := FEdgeDirection;

  if (ActiveLayer <> nil) and (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
  begin
    result := FLedDirectionFn;
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      result := FEdgeDirectionFn;
  end;
end;

procedure TKeyService.SetLedDirection(aDirection: integer);
begin
  if (ActiveLayer = nil) or (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeDirection := aDirection
    else
      FLedDirection := aDirection;
  end
  else
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeDirectionFn := aDirection
    else
      FLedDirectionFn := aDirection;
  end;
end;

procedure TKeyService.SetLedColorMono(aColor: TColor);
begin
  if (ActiveLayer = nil) or (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeColorMono := aColor
    else
      FLedColorMono := aColor
  end
  else
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeColorMonoFn := aColor
    else
      FLedColorMonoFn := aColor;
  end;
end;

function TKeyService.GetLedColorMono: TColor;
begin
  result := FLedColorMono;
  if (ConfigMode = CONFIG_EDGE_LIGHTING) then
    result := FEdgeColorMono;

  if (ActiveLayer <> nil) and (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
  begin
    result := FLedColorMonoFn;
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      result := FEdgeColorMonoFn;
  end;
end;

function TKeyService.GetLedColorReactive: TColor;
begin
  result := FLedColorReactive;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FLedColorReactiveFn;
  end;
end;

procedure TKeyService.SetLedColorReactive(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FLedColorReactive := aColor
    else
      FLedColorReactiveFn := aColor;
  end
  else
    FLedColorReactive := aColor;
end;

function TKeyService.GetBaseLedColorReactive: TColor;
begin
  result := FBaseLedColorReactive;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FBaseLedColorReactiveFn;
  end;
end;

procedure TKeyService.SetBaseLedColorReactive(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FBaseLedColorReactive := aColor
    else
      FBaseLedColorReactiveFn := aColor;
  end
  else
    FBaseLedColorReactive := aColor;
end;

function TKeyService.GetLedColorRipple: TColor;
begin
  result := FLedColorRipple;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FLedColorRippleFn;
  end;
end;

procedure TKeyService.SetLedColorRipple(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FLedColorRipple := aColor
    else
      FLedColorRippleFn := aColor;
  end
  else
    FLedColorRipple := aColor;
end;

function TKeyService.GetBaseLedColorRipple: TColor;
begin
  result := FBaseLedColorRipple;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FBaseLedColorRippleFn;
  end;
end;

procedure TKeyService.SetBaseLedColorRipple(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FBaseLedColorRipple := aColor
    else
      FBaseLedColorRippleFn := aColor;
  end
  else
    FBaseLedColorRipple := aColor;
end;

function TKeyService.GetLedColorFireball: TColor;
begin
  result := FLedColorFireball;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FLedColorFireballFn;
  end;
end;

procedure TKeyService.SetLedColorFireball(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FLedColorFireball := aColor
    else
      FLedColorFireballFn := aColor;
  end
  else
    FLedColorFireball := aColor;
end;

function TKeyService.GetBaseLedColorFireball: TColor;
begin
  result := FBaseLedColorFireball;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FBaseLedColorFireballFn;
  end;
end;

procedure TKeyService.SetBaseLedColorFireball(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FBaseLedColorFireball := aColor
    else
      FBaseLedColorFireballFn := aColor;
  end
  else
    FBaseLedColorFireball := aColor;
end;

function TKeyService.GetLedColorStarlight: TColor;
begin
  result := FLedColorStarlight;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FLedColorStarlightFn;
  end;
end;

procedure TKeyService.SetLedColorStarlight(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FLedColorStarlight := aColor
    else
      FLedColorStarlightFn := aColor;
  end
  else
    FLedColorStarlight := aColor;
end;

function TKeyService.GetBaseLedColorStarlight: TColor;
begin
  result := FBaseLedColorStarlight;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FBaseLedColorStarlightFn;
  end;
end;

procedure TKeyService.SetBaseLedColorStarlight(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FBaseLedColorStarlight := aColor
    else
      FBaseLedColorStarlightFn := aColor;
  end
  else
    FBaseLedColorStarlight := aColor;
end;

function TKeyService.GetLedColorRebound: TColor;
begin
  result := FLedColorRebound;
  if (ConfigMode = CONFIG_EDGE_LIGHTING) then
    result := FEdgeColorRebound;

  if (ActiveLayer <> nil) and (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
  begin
    result := FLedColorReboundFn;
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      result := FEdgeColorReboundFn;
  end;
end;

procedure TKeyService.SetLedColorRebound(aColor: TColor);
begin
  if (ActiveLayer = nil) or (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeColorRebound := aColor
    else
      FLedColorRebound := aColor
  end
  else
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeColorReboundFn := aColor
    else
      FLedColorReboundFn := aColor;
  end;
end;

function TKeyService.GetBaseLedColorRebound: TColor;
begin
  result := FBaseLedColorRebound;
  if (ConfigMode = CONFIG_EDGE_LIGHTING) then
    result := FBaseEdgeColorRebound;

  if (ActiveLayer <> nil) and (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
  begin
    result := FBaseLedColorReboundFn;
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      result := FBaseEdgeColorReboundFn;
  end;
end;

procedure TKeyService.SetBaseLedColorRebound(aColor: TColor);
begin
  if (ActiveLayer = nil) or (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FBaseEdgeColorRebound := aColor
    else
      FBaseLedColorRebound := aColor
  end
  else
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FBaseEdgeColorReboundFn := aColor
    else
      FBaseLedColorReboundFn := aColor;
  end;
end;

function TKeyService.GetLedColorLoop: TColor;
begin
  result := FLedColorLoop;
  if (ConfigMode = CONFIG_EDGE_LIGHTING) then
    result := FEdgeColorLoop;

  if (ActiveLayer <> nil) and (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
  begin
    result := FLedColorLoopFn;
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      result := FEdgeColorLoopFn;
  end;
end;

procedure TKeyService.SetLedColorLoop(aColor: TColor);
begin
  if (ActiveLayer = nil) or (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeColorLoop := aColor
    else
      FLedColorLoop := aColor
  end
  else
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FEdgeColorLoopFn := aColor
    else
      FLedColorLoopFn := aColor;
  end;
end;

function TKeyService.GetBaseLedColorLoop: TColor;
begin
  result := FBaseLedColorLoop;
  if (ConfigMode = CONFIG_EDGE_LIGHTING) then
    result := FBaseEdgeColorLoop;

  if (ActiveLayer <> nil) and (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
  begin
    result := FBaseLedColorLoopFn;
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      result := FBaseEdgeColorLoopFn;
  end;
end;

procedure TKeyService.SetBaseLedColorLoop(aColor: TColor);
begin
  if (ActiveLayer = nil) or (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FBaseEdgeColorLoop := aColor
    else
      FBaseLedColorLoop := aColor
  end
  else
  begin
    if (ConfigMode = CONFIG_EDGE_LIGHTING) then
      FBaseEdgeColorLoopFn := aColor
    else
      FBaseLedColorLoopFn := aColor;
  end;
end;

function TKeyService.GetLedColorRain: TColor;
begin
  result := FLedColorRain;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FLedColorRainFn;
  end;
end;

procedure TKeyService.SetLedColorRain(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FLedColorRain := aColor
    else
      FLedColorRainFn := aColor;
  end
  else
    FLedColorRain := aColor;
end;

function TKeyService.GetBaseLedColorRain: TColor;
begin
  result := FBaseLedColorRain;
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = BOTLAYER_IDX) then
      result := FBaseLedColorRainFn;
  end;
end;

procedure TKeyService.SetBaseLedColorRain(aColor: TColor);
begin
  if (ActiveLayer <> nil) then
  begin
    if (ActiveLayer.LayerIndex = TOPLAYER_IDX) then
      FBaseLedColorRain := aColor
    else
      FBaseLedColorRainFn := aColor;
  end
  else
    FBaseLedColorRain := aColor;
end;

//Converts text file content to layer/key values
procedure TKeyService.ConvertFromTextFileFmtAdv2(aLayoutContent: TStringList);
var
  aKey, newKey: TKey;
  sKey: string;
  keyState: TKeyState;
  keyStart, keyEnd: integer;
  lastKey: integer;
  previousKey: TKey;
  replacementKey: string;

  i: integer;
  currentLine: string;
  posSep: integer;
  isSingleKey: boolean;
  isMacro: boolean;
  isTapHold: boolean;
  isKeypadLayer: boolean;
  configText: string;
  valueText: string;
  aKBKey: TKBKey;
  layerIdx: integer;
  aCoTriggers: TKeyList;
  activeMacro: TKeyList;
  vkException: integer;
  tapHold: integer;
begin
  lastKey := 0;
  aCoTriggers := TKeyList.Create;

  ResetLayout;

  if (aLayoutContent.Count > 0) then
  begin
    for i := 0 to aLayoutContent.Count - 1 do
    begin
      currentLine := AnsiLowerCase(aLayoutContent.Strings[i]);

      //Reset values
      isKeypadLayer := false;
      aCoTriggers.Clear;
      aKBKey := nil;
      activeMacro := nil;
      ClearModifiers;

      posSep := Pos('>', currentLine);
      isSingleKey := Copy(currentLine, 1, 1) = SK_START;
      isMacro := Copy(currentLine, 1, 1) = MK_START;
      isTapHold := isSingleKey and (Pos('[' + TAP_AND_HOLD, currentLine) > 0);

      //Check if it's a valid line
      if (posSep <> 0) and (isSingleKey or isMacro or isTapHold) then
      begin
        configText := Copy(currentLine, 1, posSep - 1);
        valueText := Copy(currentLine, posSep + 1, Length(currentLine));

        if (isTapHold) then
        begin
          //Load configured key
          keyStart := Pos(SK_START, configText);
          keyEnd := Pos(SK_END, configText);
          sKey := Copy(configText, keyStart + 1, keyEnd - 2);
          isKeypadLayer := (Pos(KEYPAD_KEY, sKey) <> 0) or (KeyPadException(sKey));
          if (isKeypadLayer) then
          begin
            layerIdx := BOTLAYER_IDX;
            if (Pos(KEYPAD_KEY, sKey) <> 0) then
              Delete(sKey, 1, length(KEYPAD_KEY)); //removes kp- text
          end
          else
            layerIdx := TOPLAYER_IDX;
          vkException := GetKeyPadException(sKey);
          if (vkException > 0) then
            aKey := FindKeyConfig(vkException)
          else
            aKey := FindKeyConfig(sKey);

          //Gets key from layer
          if aKey <> nil then
            aKBKey := GetPositionKBKey(aKey.Key, layerIdx);

          if (aKBKey <> nil) then
          begin
            aKBKey.TapAndHold := true;
            //Load values for tap and hold
            for tapHold := 1 to 3 do
            begin
              keyStart := Pos(SK_START, valueText);
              keyEnd := Pos(SK_END, valueText);
              sKey := Copy(valueText, keyStart + 1, keyEnd - 2);
              Delete(valueText, 1, keyEnd); //removes currentkey

              //Sets modified key
              if (tapHold = 1) or (tapHold = 3) then
              begin
                aKey := FindKeyConfig(sKey);
                if aKey <> nil then
                begin
                  if (tapHold = 1) then
                    aKBKey.TapAction := aKey.CopyKey
                  else
                    aKBKey.HoldAction := aKey.CopyKey;
                end;
              end
              else
              begin
                sKey := Copy(sKey, Length(TAP_AND_HOLD) + 1, Length(sKey));
                aKBKey.TimingDelay := ConvertToInt(sKey, DEFAULT_SPEED_TAP_HOLD);
              end;
            end;
          end;
        end
        else if (isSingleKey) then
        begin
          //Load configured key
          keyStart := Pos(SK_START, configText);
          keyEnd := Pos(SK_END, configText);
          sKey := Copy(configText, keyStart + 1, keyEnd - 2);
          isKeypadLayer := (Pos(KEYPAD_KEY, sKey) <> 0) or (KeyPadException(sKey));
          if (isKeypadLayer) then
          begin
            layerIdx := BOTLAYER_IDX;
            if (Pos(KEYPAD_KEY, sKey) <> 0) then
              Delete(sKey, 1, length(KEYPAD_KEY)); //removes kp- text
          end
          else
            layerIdx := TOPLAYER_IDX;
          vkException := GetKeyPadException(sKey);
          if (vkException > 0) then
            aKey := FindKeyConfig(vkException)
          else
            aKey := FindKeyConfig(sKey);

          //Gets key from layer
          if aKey <> nil then
            aKBKey := GetPositionKBKey(aKey.Key, layerIdx);

          if (aKBKey <> nil) then
          begin
            //Load value key
            isKeypadLayer := Pos(KEYPAD_KEY, valueText) <> 0;
            keyStart := Pos(SK_START, valueText);
            keyEnd := Pos(SK_END, valueText);
            sKey := Copy(valueText, keyStart + 1, keyEnd - 2);
            if (isKeypadLayer) then
              Delete(sKey, 1, length(KEYPAD_KEY)); //removes kp- text

            //Sets modified key
            vkException := GetKeyPadException(sKey);
            if (vkException > 0) then
              aKey := FindKeyConfig(vkException)
            else
              aKey := FindKeyConfig(sKey);
            if aKey <> nil then
              SetKBKey(aKBKey, aKey.Key, false);
          end;
        end
        else if (isMacro) then
        begin
          //Loads key and co-triggers
          while (configText <> '') do
          begin
            aKey := nil;
            keyStart := Pos(MK_START, configText);
            keyEnd := Pos(MK_END, configText);
            sKey := Copy(configText, keyStart + 1, keyEnd - 2);
            isKeypadLayer := (Pos(KEYPAD_KEY, sKey) <> 0) or (KeyPadException(sKey));
            if (isKeypadLayer) then
            begin
              layerIdx := BOTLAYER_IDX;
              if (Pos(KEYPAD_KEY, sKey) <> 0) then
                Delete(sKey, 1, length(KEYPAD_KEY)); //removes kp- text
            end
            else
              layerIdx := TOPLAYER_IDX;
            Delete(configText, 1, keyEnd); //remove currentkey

            //Finds key in config
            vkException := GetKeyPadException(sKey);
            if (vkException > 0) then
              aKey := FindKeyConfig(vkException)
            else
              aKey := FindKeyConfig(sKey);

            if (aKey <> nil) then
            begin
              if (IsModifier(aKey.Key)) and (configText <> '') then
                aCoTriggers.Add(aKey.CopyKey)
              else
                aKBKey := GetPositionKBKey(aKey.Key, layerIdx, true);
            end;
          end;

          //Loads active Macro
          if (aKBKey <> nil) then
          begin
            if (aKBKey.Macro1.Count = 0) then
              activeMacro := aKBKey.Macro1
            else if (aKBKey.Macro2.Count = 0) then
              activeMacro := aKBKey.Macro2
            else if (aKBKey.Macro3.Count = 0) then
              activeMacro := aKBKey.Macro3
            else if (aKBKey.Macro4.Count = 0) then
              activeMacro := aKBKey.Macro4
            else if (aKBKey.Macro5.Count = 0) then
              activeMacro := aKBKey.Macro5;
          end;

          //If kbKey and activeMacro, load values
          if (aKBKey <> nil) and (activeMacro <> nil) then
          begin
            aKBKey.IsMacro := true;

            if (aCoTriggers.Count >= 1) then
              activeMacro.CoTrigger1 := aCoTriggers[0].CopyKey;
            if (aCoTriggers.Count >= 2) then
              activeMacro.CoTrigger2 := aCoTriggers[1].CopyKey;
            if (aCoTriggers.Count >= 3) then
              activeMacro.CoTrigger3 := aCoTriggers[2].CopyKey;

            //Get Macro text
            while (valueText <> '') do
            begin
              aKey := nil;
              keyStart := Pos(MK_START, valueText);
              keyEnd := Pos(MK_END, valueText);
              sKey := Copy(valueText, keyStart + 1, keyEnd - 2);
              if copy(sKey, 1, 1) = '-' then  //Checks for keyup or keydown
                keyState := ksDown
              else if copy(sKey, 1, 1) = '+' then
                keyState := ksUp
              else
                keyState := ksNone;
              if keyState <> ksNone then
                Delete(sKey, 1, 1); //removes - or +
              if (Pos(KEYPAD_KEY, sKey) <> 0) then
                Delete(sKey, 1, length(KEYPAD_KEY)); //removes kp- text
              Delete(valueText, 1, keyEnd); //removes currentkey

              if (activeMacro.Count = 0) and (Copy(sKey, 1, Length(MACRO_SPEED_TEXT)) = MACRO_SPEED_TEXT) then
              begin
                activeMacro.MacroSpeed := ConvertToInt(Copy(sKey, Length(MACRO_SPEED_TEXT) + 1, Length(MACRO_SPEED_TEXT) + 2));
              end
              else
              begin
                //Finds key in config
                vkException := GetKeyPadException(sKey);
                if (vkException > 0) then
                  aKey := FindKeyConfig(vkException)
                else
                  aKey := FindKeyConfig(sKey);

                //Checks for replacement key values (US English)
                if aKey <> nil then
                begin
                  replacementKey := GetReplacementKey(aKey.Key, false);
                  if (replacementKey <> '') then
                    aKey := FindKeyConfig(replacementKey);
                end;
              end;

              if aKey <> nil then
              begin
                if IsModifier(aKey.Key) then
                begin
                  //Adds to list of active modifiers
                  if (keyState = ksDown) then
                    AddModifier(aKey.key)
                  else if (keyState = ksUp) then
                  begin
                    //If last key is the same key, then adds modifier as single key down
                    if lastKey = aKey.Key then
                      activeMacro.Add(aKey.CopyKey);
                    RemoveModifier(aKey.Key);
                  end
                  else //if no keyState (+ or -) and modifier add as single key
                    activeMacro.Add(aKey.CopyKey);
                end
                else if (keyState in [ksNone, ksDown]) then //Only add key on key down or key none
                begin
                  //Get the previous key
                  if activeMacro.Count > 0 then
                    previousKey := activeMacro.Items[activeMacro.Count - 1];

                  //If there are modifiers and we find Different Press and Release, we assign it to previous key
                  if (ActiveModifiers.Count > 0) and (aKey.Key = VK_DIF_PRESS_REL) and (previousKey <> nil) then
                  begin
                    previousKey.DiffPressRel := true;
                  end
                  else //Add the key
                  begin
                    newKey := akey.CopyKey;
                    newKey.Modifiers := GetModifierText; //Gets modifier values
                    activeMacro.Add(newKey); //Adds key
                  end;
                end;
                lastKey := aKey.Key;
              end;
            end; //end while loop valueText
          end;
        end;
      end;
    end;
  end;
  ClearModifiers;
end;

function TKeyService.GetTextMacro(aKey: TKey; macro: TKeyList; layerPrefix: string): string;
var
  i, j: integer;
  prevModifiers: string;
  saveValue: string;
  curKeyModifiers: TKeyList;
  prevKeyModifiers: TKeyList;
begin
  result := '';

  if (macro.Count > 0) then
  begin
    curKeyModifiers := TKeyList.Create;
    prevKeyModifiers := TKeyList.Create;

    //Add layer prefix if there
    result := result + layerPrefix;

    //Add the co-triggers first
    if (macro.CoTrigger1 <> nil) then
      result := result + '{' + macro.CoTrigger1.SaveValue + '}';
    if (macro.CoTrigger2 <> nil) then
      result := result + '{' + macro.CoTrigger2.SaveValue + '}';
    if (macro.CoTrigger3 <> nil) then
      result := result + '{' + macro.CoTrigger3.SaveValue + '}';
    if (macro.CoTrigger4 <> nil) then
      result := result + '{' + macro.CoTrigger4.SaveValue + '}';

    //Add the modified key
    result := result + '{' + aKey.SaveValue + '}';

    //Add the character separating config and value keys
    result := result + '>';

    if (macro.MacroSpeed >= 0) and (macro.MacroSpeed <= MACRO_SPEED_MAX_RGB) then
    begin
      result := result + '{' + MACRO_SPEED_TEXT_EDGE + IntToStr(macro.MacroSpeed) + '}';
    end;

    if (macro.MacroRptFreq >= 0) and (macro.MacroRptFreq <= MACRO_FREQ_MAX_RGB) then
    begin
      result := result + '{' + MACRO_REPEAT_EDGE + IntToStr(macro.MacroRptFreq) + '}';
    end;

    for i := 0 to macro.Count - 1 do
    begin
      prevModifiers := '';
      curKeyModifiers.Clear;
      prevKeyModifiers.Clear;;

      aKey := macro[i];

      //Gets the key save value
      saveValue := aKey.SaveValue;

      //Fills list of modifiers
      if not IsModifier(aKey.Key) then
        FillModifiersFromValues(curKeyModifiers, aKey.Modifiers);

      //Loads previous key modifiers
      if (i >= 1) and not(IsModifier(macro[i - 1].Key)) then
      begin
        prevModifiers := macro[i - 1].Modifiers;
        FillModifiersFromValues(prevKeyModifiers, prevModifiers);
      end;

      //Checks any change in modifiers (add or remove any)
      if (prevModifiers <> aKey.Modifiers) then
      begin
        //Add text + when modifier is released
        for j := 0 to prevKeyModifiers.Count - 1 do
        begin
          if not curKeyModifiers.ContrainsKey(prevKeyModifiers[j]) then
            result := result + '{+' + prevKeyModifiers.Items[j].SaveValue + '}';
        end;

        //Add text - when modifier is pressed
        for j := 0 to curKeyModifiers.Count - 1 do
        begin
          if not prevKeyModifiers.ContrainsKey(curKeyModifiers[j]) then
            result := result + '{-' + curKeyModifiers.Items[j].SaveValue + '}';
        end;
      end;

      //If different press & release with combination, write using the old method with up and down value
      if (GApplication = APPL_PEDAL) and (aKey.DiffPressRel) then
      begin
        //Writes the key - and + if WriteDownUp is enabled, else writes only the value
        if aKey.WriteDownUp then
          result := result + '{-' + saveValue + '}' + DIFF_PRESS_REL_TEXT + '{+' + saveValue + '}'
        else
          result := result + '{' + saveValue + '}';
      end
      else  //Write the key value, only need the - / + for modifiers
      begin
        if (aKey.UpDown = ksNone) then
          result := result + '{' + saveValue + '}'
        else if (aKey.UpDown = ksUp) then
          result := result + '{+' + saveValue + '}'
        else if (aKey.UpDown = ksDown) then
          result := result + '{-' + saveValue + '}';
      end;

      //If last key set modifiers +
      if (i = macro.Count - 1) then
      begin
        for j := 0 to curKeyModifiers.Count - 1 do
          result := result + '{+' + curKeyModifiers[j].SaveValue + '}';
      end;
    end;

    if (curKeyModifiers <> nil) then
      FreeAndNil(curKeyModifiers);
    if (prevKeyModifiers <> nil) then
      FreeAndNil(prevKeyModifiers);
  end;
end;

function TKeyService.ConvertToTextFileFmt: TStringList;
var
  i, j: integer;
  lIdx, kIdx, mIdx: integer;
  lineText: string;
  saveValue: string;
  layoutContent: TStringList;
  aLayer: TKBLayer;
  aKbKey: TKBKey;
  aKey: TKey;
  aMacro: TKeyList;
  layerPrefix: string;
  lastLayer: integer;
  layerHeader: string;
  textLine: TTextLine;

  function GetLayerHeader(idx: integer): string;
  begin
    if (idx = LAYER_BASE_360) then
      result := TEXT_LAYER_DEFAULT
    else if (idx = LAYER_KEYPAD_360) then
      result := TEXT_LAYER_KP
    else if (idx = LAYER_FN1_360) then
      result := TEXT_LAYER_FN1
    else if (idx = LAYER_FN2_360) then
      result := TEXT_LAYER_FN2
    else if (idx = LAYER_FN3_360) then
      result := TEXT_LAYER_FN3
    else
      result := '';
  end;
begin
  layoutContent := TStringList.Create;
  lastLayer := -1;

  for lIdx := 0 to FKBLayers.Count - 1 do
  begin
    //Add layer header for Gen2 devices
    if (IsGen2Device(GApplication) and (lastLayer <> lIdx)) then
    begin
      layerHeader := GetLayerHeader(lIdx);
      if (layerHeader <> '') then
        layoutContent.Add(layerHeader);
    end;

    lastLayer := lIdx;
    layerPrefix := '';
    aLayer := FKBLayers[lIdx];
    if (not IsGen2Device(GApplication)) and (aLayer.LayerIndex = BOTLAYER_IDX) then
      layerPrefix := KEYPAD_KEY_EDGE;

    for kIdx := 0 to aLayer.KBKeyList.Count - 1 do
    begin
      lineText := '';
      aKbKey := aLayer.KBKeyList[kIdx];

      //If key is tap and hold
      if (aKbKey.TapAndHold) and (aKbKey.TapAction <> nil) and (aKbKey.HoldAction <> nil) then
      begin
        lineText := layerPrefix + '[' + aKbKey.PositionKey.SaveValue + ']>[' + aKbKey.TapAction.SaveValue + ']' +
          '[' + TAP_AND_HOLD + IntToStr(aKbKey.TimingDelay) + ']' + '[' + aKbKey.HoldAction.SaveValue + ']';
        layoutContent.Add(lineText);
      end
      else if (aKbKey.Multimodifiers <> '') then
      begin
        lineText := layerPrefix + '[' + aKbKey.PositionKey.SaveValue + ']>[' + aKbKey.Multimodifiers + ']';
        layoutContent.Add(lineText);
      end
      //If key is modified / remapped
      else if (aKbKey.IsModified) then
      begin
        lineText := layerPrefix + '[' + aKbKey.PositionKey.SaveValue + ']>[' + aKbKey.ModifiedKey.SaveValue + ']';
        layoutContent.Add(lineText);
      end;

      if (aKbKey.IsMacro) and (not IsGen2Device(GApplication)) then
      begin
        //Loop through the 3 macros
        for mIdx := 1 to 5 do
        begin
          //Select the correct macro
          if (mIdx = 1) then
            aMacro := aKbKey.Macro1
          else if (mIdx = 2) then
            aMacro := aKbKey.Macro2
          else if (mIdx = 3) then
            aMacro := aKbKey.Macro3
          else if (mIdx = 4) then
            aMacro := aKbKey.Macro4
          else
            aMacro := aKbKey.Macro5;

          ////Skip if macro has no keys
          //if (aMacro.Count <= 0) then
          //  continue;

          //Get macro text
          lineText := GetTextMacro(aKbKey.PositionKey, aMacro, layerPrefix);

          //Add line to text file
          if (lineText <> '') then
            layoutContent.Add(lineText);
        end;
      end;
    end;

    //Save macros for gen2 devices
    if IsGen2Device(GApplication) then
    begin
      for mIdx := 0 to FMacros.Count - 1 do
      begin
        aMacro := TKeyList(FMacros[mIdx]);
        if (aMacro.LayerIdx = lIdx) then
        begin
          aKey := FindKeyConfig(aMacro.TriggerKey);

          //Get macro text
          lineText := GetTextMacro(aKey, aMacro, layerPrefix);

          //Add line to text file
          if (lineText <> '') then
            layoutContent.Add(lineText);
        end;
      end;
    end;

    //Invalid lines to keep
    for kIdx := 0 to TextLines.Count - 1 do
    begin
      textLine := TextLines[kIdx];
      if ((not textLine.IsValid) and (textLine.LayerIdx = aLayer.LayerIndex)) then
      begin
        if (textLine.Keep and (not textLine.Removed)) then
          layoutContent.Add(textLine.RawText)
        else
          textLine.Removed := true;
      end;
    end;
  end;

  Result := layoutContent;
end;

//Converts keys from program to format for the text file
function TKeyService.ConvertToTextFileFmtAdv2: TStringList;
var
  i, j: integer;
  lIdx, kIdx, mIdx: integer;
  lineText: string;
  saveValue: string;
  layoutContent: TStringList;
  aLayer: TKBLayer;
  aKbKey: TKBKey;
  aKey: TKey;
  aMacro: TKeyList;
  layerPrefix: string;
  prevModifiers: string;
  curKeyModifiers: TKeyList;
  prevKeyModifiers: TKeyList;

  function GetLayerPrefix(saveValue: string): string;
  begin
    if not KeyPadException(saveValue) then
      result := layerPrefix
    else
      result := '';
  end;

begin
  layoutContent := TStringList.Create;

  for lIdx := 0 to FKBLayers.Count - 1 do
  begin
    layerPrefix := '';
    aLayer := FKBLayers[lIdx];
    if (aLayer.LayerIndex = BOTLAYER_IDX) then
      layerPrefix := 'kp-';

    for kIdx := 0 to aLayer.KBKeyList.Count - 1 do
    begin
      lineText := '';
      aKbKey := aLayer.KBKeyList[kIdx];

      //If key is tap and hold
      if (aKbKey.TapAndHold) and (aKbKey.TapAction <> nil) and (aKbKey.HoldAction <> nil) then
      begin
        lineText := '[' + GetLayerPrefix(aKbKey.PositionKey.SaveValue) + aKbKey.PositionKey.SaveValue + ']>[' + aKbKey.TapAction.SaveValue + ']' +
          '[' + TAP_AND_HOLD + IntToStr(aKbKey.TimingDelay) + ']' + '[' + aKbKey.HoldAction.SaveValue + ']';
        layoutContent.Add(lineText);
      end
      //If key is modified / remapped
      else if (aKbKey.IsModified) then
      begin
        lineText := '[' + GetLayerPrefix(aKbKey.PositionKey.SaveValue) + aKbKey.PositionKey.SaveValue + ']>[' + aKbKey.ModifiedKey.SaveValue + ']';
        layoutContent.Add(lineText);
      end;

      //jm todo Can be modified and have macro??
      //jm todo Do we put kp- for macro values??
      if (aKbKey.IsMacro) then
      begin
        curKeyModifiers := TKeyList.Create;
        prevKeyModifiers := TKeyList.Create;

        //Loop through the 3 macros
        for mIdx := 1 to 3 do
        begin
          lineText := '';

          //Select the correct macro
          if (mIdx = 1) then
            aMacro := aKbKey.Macro1
          else if (mIdx = 2) then
            aMacro := aKbKey.Macro2
          else if (mIdx = 3) then
            aMacro := aKbKey.Macro3
          else if (mIdx = 4) then
            aMacro := aKbKey.Macro4
          else
            aMacro := aKbKey.Macro5;

          //Skip if macro has no keys
          if (aMacro.Count <= 0) then
            continue;

          //Add the co-triggers first
          if (aMacro.CoTrigger1 <> nil) then
            lineText := '{' + GetLayerPrefix(aMacro.CoTrigger1.SaveValue) + aMacro.CoTrigger1.SaveValue + '}';
          if (aMacro.CoTrigger2 <> nil) then
            lineText := lineText + '{' + GetLayerPrefix(aMacro.CoTrigger2.SaveValue) + aMacro.CoTrigger2.SaveValue + '}';
          if (aMacro.CoTrigger3 <> nil) then
            lineText := lineText + '{' + GetLayerPrefix(aMacro.CoTrigger3.SaveValue) + aMacro.CoTrigger3.SaveValue + '}';

          //Add the modified key
          lineText := lineText + '{' + GetLayerPrefix(aKbKey.PositionKey.SaveValue) + aKbKey.PositionKey.SaveValue + '}';

          //Add the character separating config and value keys
          lineText := lineText + '>';

          //jm todo: compare with global macro speed...
          if (aMacro.MacroSpeed >= 1) and (aMacro.MacroSpeed <= MACRO_SPEED_MAX_ADV2) then
          begin
            lineText := lineText + '{' + MACRO_SPEED_TEXT + IntToStr(aMacro.MacroSpeed) + '}';
          end;

          for i := 0 to aMacro.Count - 1 do
          begin
            prevModifiers := '';
            curKeyModifiers.Clear;
            prevKeyModifiers.Clear;;

            aKey := aMacro[i];

            //Gets the key save value
            saveValue := aKey.SaveValue;

            //Fills list of modifiers
            FillModifiersFromValues(curKeyModifiers, aKey.Modifiers);

            //Loads previous key modifiers
            if (i >= 1) then
            begin
              prevModifiers := aMacro[i - 1].Modifiers;
              FillModifiersFromValues(prevKeyModifiers, prevModifiers);
            end;

            //Checks any change in modifiers (add or remove any)
            if (prevModifiers <> aKey.Modifiers) then
            begin
              //Add text + when modifier is released
              for j := 0 to prevKeyModifiers.Count - 1 do
              begin
                if not curKeyModifiers.ContrainsKey(prevKeyModifiers[j]) then
                  lineText := lineText + '{+' + prevKeyModifiers.Items[j].SaveValue + '}';
              end;

              //Add text - when modifier is pressed
              for j := 0 to curKeyModifiers.Count - 1 do
              begin
                if not prevKeyModifiers.ContrainsKey(curKeyModifiers[j]) then
                  lineText := lineText + '{-' + curKeyModifiers.Items[j].SaveValue + '}';
              end;
            end;

            //If different press & release with combination, write using the old method with up and down value
            if (aKey.DiffPressRel) then
            begin
              //Writes the key - and + if WriteDownUp is enabled, else writes only the value
              if aKey.WriteDownUp then
                lineText := lineText + '{-' + saveValue + '}' + DIFF_PRESS_REL_TEXT + '{+' + saveValue + '}'
              else
                lineText := lineText + '{' + saveValue + '}';
            end
            else  //Write the key value, only need the - / + for modifiers
              lineText := lineText + '{' + saveValue + '}';

            //If last key set modifiers +
            if (i = aMacro.Count - 1) then
            begin
              for j := 0 to curKeyModifiers.Count - 1 do
                lineText := lineText + '{+' + curKeyModifiers[j].SaveValue + '}';
            end;
          end;

          //Add line to text file
          layoutContent.Add(lineText);
        end;

        FreeAndNil(curKeyModifiers);
        FreeAndNil(prevKeyModifiers);
      end;
    end;
  end;

  Result := layoutContent;
end;

function TKeyService.IsShiftDown(aKey: TKey): boolean;
begin
  result := (aKey.Modifiers = SHIFT_MOD) or (aKey.Modifiers = L_SHIFT_MOD) or (aKey.Modifiers = R_SHIFT_MOD);
end;

//Checks for replacement key values (non US English drivers)
function TKeyService.GetReplacementKey(aKey: word; saving: boolean): string;
var
  returnKey: word;
  key: TKey;
begin
  result := '';
  {$ifdef Win64}
  if (GApplication = APPL_PEDAL) and (FCurrentKBLayout <> ENGLISH_US_LAYOUT_NAME) then
  begin
    if (saving) then
      returnKey := ConvertToEnUS(aKey)
    else
      returnKey := ConvertToLayout(aKey);
    key := FindKeyConfig(returnKey);
    if key <> nil then
      result := key.SaveValue;
  end;
  {$endif}
end;

procedure TKeyService.ResetLayout;
var
  i: integer;
begin
  for i := 0 to KBLayers.Count - 1 do
    ResetLayer(KBLayers[i]);
  FTextLines.Clear;
end;

procedure TKeyService.ResetLayer(aLayer: TKBLayer);
var
  i:integer;
  kbKey: TKBKey;
begin
  if (aLayer <> nil) then
  begin
    for i := 0 to aLayer.KBKeyList.Count - 1 do
    begin
      kbKey := aLayer.KBKeyList[i];
      kbKey.ResetKey;
    end;
  end;
end;

procedure TKeyService.ResetKey(aLayer: TKBLayer; key: word);
var
  aKBKey: TKBKey;
begin
  aKBKey := GetKbKeyByIndex(aLayer, key);
  if (aKBKey <> nil) then
    aKBKey.ResetKey;
end;

function TKeyService.GetLayer(layerIdx: integer): TKBLayer;
var
  i:integer;
begin
  result := nil;

  for i := 0 to FKBLayers.Count - 1 do
  begin
    if (FKBLayers[i].LayerIndex = layerIdx) then
      result := FKBLayers[i];
  end;
end;

procedure TKeyService.SetKBKey(aKBKey: TKBKey; key: word; overwriteTapHold: boolean);
var
  aKey: TKey;
begin
  aKey := GetKeyConfig(key);
  if (aKey <> nil) then
  begin
    if (aKBKey.OriginalKey.Key <> aKey.Key) and (aKBKey.CanEdit) then
    begin
      aKBKey.ModifiedKey := aKey;
      aKBKey.IsModified := true;
    end
    else
    begin
      aKBKey.ModifiedKey := nil;
      aKBKey.IsModified := false;
    end;

    if (overwriteTapHold) then
      ResetTapHold(aKBKey);
  end;
end;

procedure TKeyService.SetTapAndHold(aKBKey: TKBKey; tapAction: integer; holdAction: integer;
  delay: integer);
var
  aTapAction: TKey;
  aHoldAction: TKey;
begin
  aTapAction := GetKeyConfig(tapAction);
  aHoldAction := GetKeyConfig(holdAction);
  if (aTapAction <> nil) and (aHoldAction <> nil) then
  begin
    aKBKey.TapAction := aTapAction;
    aKBKey.HoldAction := aHoldAction;
    aKBKey.TimingDelay := delay;
    aKbKey.TapAndHold := true;
  end
  else
  begin
    ResetTapHold(aKbKey);
  end;
end;

procedure TKeyService.ResetTapHold(aKBKey: TKBKey);
begin
  aKBKey.TapAction := nil;
  aKBKey.HoldAction := nil;
  aKBKey.TimingDelay := 0;
  aKbKey.TapAndHold := false;
end;

procedure TKeyService.SetKBKeyIdx(aLayer: TKBLayer; index: integer;
  key: word; overwriteTapHold: boolean = true);
var
  aKey: TKey;
  aKbKey: TKBKey;
begin
  aKey := GetKeyConfig(key);
  aKbKey := GetKbKeyByIndex(aLayer, index);
  if (aKey <> nil) and (aKbKey <> nil) and (aLayer <> nil) then
  begin
    if (aKBKey.OriginalKey.Key <> aKey.Key) and (aKBKey.CanEdit) then
    begin
      aKBKey.ModifiedKey := aKey;
      aKBKey.IsModified := true;
    end
    else
    begin
      aKBKey.ModifiedKey := nil;
      aKBKey.IsModified := false;
    end;

    if (overwriteTapHold) then
        ResetTapHold(aKBKey);
  end;
end;

procedure TKeyService.SetKeyMacroIdx(aLayer: TKBLayer; index: integer; aMacro: TKeyList;
  resetMacro: boolean);
var
  aKbKey: TKBKey;
begin
  aKbKey := GetKbKeyByIndex(aLayer, index);
  if (aKBKey <> nil) and (aMacro <> nil) then
  begin
    if (resetMacro) then
      aKBKey.ResetMacro;
    aKBKey.Macro1.Assign(aMacro);
    aKBKey.IsMacro := true;
    aKBKey.ActiveMacro := aKBKey.Macro1;
  end;
end;

function TKeyService.GetKBKey(key: word; layerIdx: integer): TKBKey;
var
  keyIdx: integer;
  aLayer: TKBLayer;
  aKey: TKBKey;
begin
  Result := nil;

  aLayer := GetLayer(layerIdx);

  if (aLayer <> nil) then
    for keyIdx := 0 to aLayer.KBKeyList.Count - 1 do
    begin
      aKey := aLayer.KBKeyList[keyIdx];
      if (aKey.OriginalKey.Key = key) then
      begin
        result := aKey;
        break;
      end;
    end;
end;

//Get KB Key based on position token
function TKeyService.GetPositionKBKey(key: word; layerIdx: integer; isMacro: boolean = false): TKBKey;
var
  keyIdx: integer;
  aLayer: TKBLayer;
  aKey: TKBKey;
begin
  Result := nil;

  aLayer := GetLayer(layerIdx);

  if (aLayer <> nil) then
    for keyIdx := 0 to aLayer.KBKeyList.Count - 1 do
    begin
      aKey := aLayer.KBKeyList[keyIdx];
      if (isMacro) and (aKey.TriggerKey.Key = key) then
      begin
        result := aKey;
        break;
      end
      else if (aKey.PositionKey.Key = key) then
      begin
        result := aKey;
        break;
      end;
    end;
end;

function TKeyService.GetKBKeyTrigger(key: word): TKBKey;
var
  keyIdx: integer;
  layerIdx: integer;
  aLayer: TKBLayer;
  aKey: TKBKey;
begin
  Result := nil;

  for layerIdx := 0 to FKBLayers.Count - 1 do
  begin
    if (result = nil) then
    begin
      aLayer := GetLayer(layerIdx);

      for keyIdx := 0 to aLayer.KBKeyList.Count - 1 do
      begin
        aKey := aLayer.KBKeyList[keyIdx];
        if (aKey.OriginalKey.Key = key) then
        begin
          result := aKey;
          break;
        end;
      end;
    end;
  end;
end;

function TKeyService.GetEdgeKey(key: word; layerIdx: integer): TKBKey;
var
  keyIdx: integer;
  aLayer: TKBLayer;
  aKey: TKBKey;
begin
  Result := nil;

  aLayer := GetLayer(layerIdx);

  if (aLayer <> nil) then
    for keyIdx := 0 to aLayer.EdgeKeyList.Count - 1 do
    begin
      aKey := aLayer.EdgeKeyList[keyIdx];
      if (aKey.OriginalKey.Key = key) then
      begin
        result := aKey;
        break;
      end;
    end;
end;

function TKeyService.GetKbKeyByIndex(aLayer: TKBLayer; index: integer
  ): TKBKey;
var
  i: integer;
  found: boolean;
  aKbKey: TKBKey;
begin
  i := 0;
  result := nil;
  found := false;
  if (aLayer <> nil) then
  begin
    While (i < aLayer.KBKeyList.Count) and (not found) do
    begin
      aKbKey := aLayer.KBKeyList[i];
      if (aKbKey.Index = index) then
      begin
        result := aKbKey;
        found := true;
      end;
      inc(i);
    end;
  end;
end;

function TKeyService.GetEdgeKeyByIndex(aLayer: TKBLayer; index: integer): TKBKey;
var
  i: integer;
  found: boolean;
  aKbKey: TKBKey;
begin
  i := 0;
  result := nil;
  found := false;
  if (aLayer <> nil) then
  begin
    While (i < aLayer.EdgeKeyList.Count) and (not found) do
    begin
      aKbKey := aLayer.EdgeKeyList[i];
      if (aKbKey.Index = index) then
      begin
        result := aKbKey;
        found := true;
      end;
      inc(i);
    end;
  end;
end;

function TKeyService.CopyMacro(aMacro: TKeyList): TKeyList;
begin
  result := nil;
  if (aMacro <> nil) then
  begin
    result := TKeyList.Create;
    result.Assign(aMacro);
  end;
end;

function TKeyService.GetSingleKeyText(aKey: TKey; var isLongKey: boolean
  ): string;
var
  keyText: string;
  keyTextAltGr: string;
begin
  Result := '';
  keyText := GetKeyText(aKey);
  keyTextAltGr := '';
  isLongKey := false;

  //Returns shifted value if shift + key pressed (and shifted value available)
  if (IsShiftDown(aKey)) and (aKey.ShowShiftedValue) then
  begin
    Result := keyText;
  end
  //Returns modifier value (Ctrl, Shfit, Alt, Win) + key value
  else if (aKey.Modifiers <> '') and not (IsModifier(aKey.Key)) then
  begin
    {$ifdef Win64}
    if (IsAltGr(aKey)) then
      keyTextAltGr := GetKeyText(aKey, '', true);
    {$endif}

    //Shows AltGr value if keyboard layout supports it
    if (keyTextAltGr <> '') then
    begin
      Result := keyTextAltGr;
    end
    else
    begin
      Result := '{' + GetModifierValues(aKey) + keyText + '}';
      isLongKey := true;
    end;
  end
  //If has MultiValue and multikey, returns the multivalue
  else if (aKey.MultiValue <> '') then
  begin
    Result := GetKeyText(aKey, aKey.MultiValue);
  end
  //Returns value in square braquets for single key
  else
  begin
    Result := '{' + keyText + '}';

    if not(IsAlphaKey(aKey)) and not(IsNumericKey(aKey)) then
      isLongKey := true;
  end;

  if (aKey.UpDown <> ksNone) then
    isLongKey := true;
end;

function TKeyService.CompareKey(key1: word; aKeyList: TKeyList): boolean;
var
  i: integer;
begin
  result := false;

  for i := 1 to 4 do
  begin
    case i of
     1 : if (aKeyList.CoTrigger1 <> nil) then result := key1 = aKeyList.CoTrigger1.Key;
     2 : if (aKeyList.CoTrigger2 <> nil) then result := key1 = aKeyList.CoTrigger2.Key;
     3 : if (aKeyList.CoTrigger3 <> nil) then result := key1 = aKeyList.CoTrigger3.Key;
     4 : if (aKeyList.CoTrigger4 <> nil) then result := key1 = aKeyList.CoTrigger4.Key;
    end;
    if (result) then
       break;
  end;
end;

function TKeyService.CompareTriggers(aKeyList1: TKeyList; aKeyList2: TKeyList): boolean;
var
  i: integer;
begin
  result := false;

  if (aKeyList1.Count > 0) and (aKeyList2.Count > 0) then
  begin
    //First check if all co-triggers from list one are in list 2
    for i := 1 to 4 do
    begin
      case i of
       1 : if (aKeyList1.CoTrigger1 <> nil) then result := CompareKey(aKeyList1.CoTrigger1.Key, aKeyList2);
       2 : if (aKeyList1.CoTrigger2 <> nil) then result := CompareKey(aKeyList1.CoTrigger2.Key, aKeyList2);
       3 : if (aKeyList1.CoTrigger3 <> nil) then result := CompareKey(aKeyList1.CoTrigger3.Key, aKeyList2);
       4 : if (aKeyList1.CoTrigger4 <> nil) then result := CompareKey(aKeyList1.CoTrigger4.Key, aKeyList2);
      end;
    end;

    //If true, check they are the same amount of co-triggers
    if (result) then
      result := (aKeyList1.CountCoTriggers = aKeyList2.CountCoTriggers);

    //Finally, check if both have 0 co-triggers
    if (not result) then
    begin
      result := (aKeyList1.CountCoTriggers = 0) and (aKeyList2.CountCoTriggers = 0);
    end;
  end;
end;

function TKeyService.CheckUpDownKS(aKeyList: TKeyList): boolean;
var
  i, j: integer;
  aKey, aKey2: TKey;
  hasUp: boolean;
  upList: array of integer;
  isValid: boolean;

  procedure AddToList(value: integer);
  begin
    SetLength(upList, Length(upList) + 1);
    upList[High(upList)] := value;
  end;

  function AlreadyInList(value: integer): boolean;
  var
    idx: integer;
  begin
    idx := 0;
    result := false;

    while (idx < Length(upList)) and (result = false) do
    begin
      if (upList[idx] = value) then
        result := true;

      inc(idx);
    end;
  end;

begin
  isValid := true;
  SetLength(upList, 0);

  i := 0;
  While (i < aKeyList.Count) and (isValid) do
  begin
    aKey := aKeyList[i];
    if (aKey.UpDown = ksDown) then
    begin
      hasUp := false;

      j := i + 1;
      While (j < aKeyList.Count) and (not hasUp) do
      begin
        aKey2 := aKeyList[j];
        if (aKey2.Key = aKey.Key) and (aKey2.UpDown = ksUp) and not(AlreadyInList(j)) then
        begin
          hasUp := true;
          AddToList(j);
        end;
        inc(j);
      end;

      if (not hasUp) then
        isValid := false;
    end;

    inc(i);
  end;

  result := isValid;
end;

//Validate if Macros are ok, not same co-trigger for all macros
function TKeyService.ValidateMacros(aKey: TKbKey; var errorMsg: string;
  var errorMsgTitle: string): boolean;
var
  i:integer;
  coTriggersOk: boolean;
begin
  errorMsg := '';
  errorMsgTitle := '';
  coTriggersOk := true;
  if (aKey <> nil) then
  begin
    coTriggersOk := (not CompareTriggers(aKey.Macro1, aKey.Macro2)) and
      (not CompareTriggers(aKey.Macro1, aKey.Macro3)) and
      (not CompareTriggers(aKey.Macro1, aKey.Macro4)) and
      (not CompareTriggers(aKey.Macro1, aKey.Macro5)) and
      (not CompareTriggers(aKey.Macro2, aKey.Macro3)) and
      (not CompareTriggers(aKey.Macro2, aKey.Macro4)) and
      (not CompareTriggers(aKey.Macro2, aKey.Macro5)) and
      (not CompareTriggers(aKey.Macro3, aKey.Macro4)) and
      (not CompareTriggers(aKey.Macro3, aKey.Macro5)) and
      (not CompareTriggers(aKey.Macro4, aKey.Macro5));

    if (not coTriggersOk) then
    begin
      errorMsg := 'You cannot assign two different macros to the same trigger key combination. Choose a co-trigger that is not already in use.';
      errorMsgTitle := 'Duplicate Macro Trigger';
    end;

    //maxMacroOk := (aKey.Macro1.Count <= MAX_MACRO_FS) and
    //  (aKey.Macro2.Count <= MAX_MACRO_FS) and
    //  (aKey.Macro3.Count <= MAX_MACRO_FS);
    //
    //if (not maxMacroOk) then
    //  errorMsg := 'Only ' + IntToStr(MAX_MACRO_FS) + ' macros can be saved to a layout. Delete a macro to proceed.';
  end;

  result := coTriggersOk; // and maxMacroOk;
end;

//Gen2 devices
function TKeyService.ValidateMacros(aMacro: TKeyList; var errorMsg: string;
  var errorMsgTitle: string; var errorNumber: integer): boolean;
var
  i:integer;
  tempMacro: TKeyList;
  valid: boolean;
  keyCount: integer;
begin
  valid := true;
  errorMsg := '';
  errorMsgTitle := '';
  errorNumber := 0;

  if (aMacro <> nil) then
  begin
    if (aMacro.Count <= 0) then
    begin
      errorMsg := 'You macro is empty.';
      errorMsgTitle := 'Macro';
      errorNumber := 1;
      valid := false;
    end;

    if (valid) and (aMacro.LayerIdx < 0) then
    begin
      errorMsg := 'You must select a layer for this macro.';
      errorMsgTitle := 'Macro';
      errorNumber := 2;
      valid := false;
    end;

    if (valid) then
    begin
      for i := 0 to FMacros.Count - 1 do
      begin
        tempMacro := TKeyList(FMacros[i]);

        //Check hanging downstroke
        if (valid) then
        begin
          valid := CheckUpDownKS(aMacro);
          if (not valid) then
          begin
            errorMsg := 'Your new macro has a hanging downstroke which is likely to result in a stuck key. All down strokes should be followed by a corresponding upstroke in the macro.';
            errorMsgTitle := 'Up/Down Keystroke';
            errorNumber := 3;
            break;
          end;
        end;

        //Check at least 1 trigger key for certain keys
        if (valid) then
        begin
          valid := not(((aMacro.TriggerKey = VK_FN1_LAYER_SHIFT) or (aMacro.TriggerKey = VK_KP_LAYER_TOGGLE)) and (aMacro.CountCoTriggers = 0));
          if (not valid) then
          begin
            errorMsg := 'You must select at least 1 co-trigger for this key.';
            errorMsgTitle := 'Co-Trigger';
            errorNumber := 4;
            break;
          end;
        end;

        //CHECK LAST FOR REPLACE - Same trigger key, same layer and different Guid (not same macro)
        if (tempMacro.TriggerKey = aMacro.TriggerKey) and (tempMacro.LayerIdx = aMacro.LayerIdx) and (not IsEqualGUID(tempMacro.Guid, aMacro.Guid)) then
        begin
          valid := not(CompareTriggers(aMacro, tempMacro));
          if (not valid) then
          begin
            errorMsg := 'You cannot assign two different macros to the same trigger key combination. Choose a different trigger key, co-trigger, or layer.';
            errorMsgTitle := 'Duplicate Macro Trigger';
            errorNumber := 5;
            break;
          end;
        end;

        //Check for max keystrokes in Macro (Adv360)
        if (valid) and (GApplication = APPL_ADV360) then
        begin
          keyCount := CountMacroKeyStrokes(tempMacro);
          if (keyCount > MAX_KEYSTROKES_MACRO_ADV360) then
          begin
            valid := false;
            errorMsg := 'Macros are limited to ' + IntToStr(MAX_KEYSTROKES_MACRO_ADV360) + ' characters.' + #10 +
              'Current length: ' + IntToStr(keyCount);
            errorMsgTitle := 'Maximum Length Reached';
            errorNumber := 6;
            break;
          end;
        end;
      end;
    end;
  end;

  result := valid;
end;

function TKeyService.CountMacroKeyStrokes(aMacro: TKeyList): integer;
var
  macroText: string;
  aKey: TKey;
begin
  result := 0;
  if (GApplication = APPL_ADV360) then
  begin
    aKey := FindKeyConfig(aMacro.TriggerKey);

    //Get macro text that will be saved
    macroText := GetTextMacro(aKey, aMacro, '');

    result := length(macroText);
  end;
end;

function TKeyService.CountModifiers(modifiers: string): integer;
begin
  Result := 0;
  if modifiers <> '' then
  begin
    if Pos(SHIFT_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(L_SHIFT_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(R_SHIFT_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(CTRL_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(L_CTRL_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(R_CTRL_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(ALT_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(L_ALT_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(R_ALT_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(WIN_MOD, string(modifiers)) <> 0 then
      inc(result);
    if Pos(L_WIN_MOD, string(modifiers)) <> 0 then
      inc(result);
  end;
end;

function TKeyService.CountKeystrokes(aKeyList: TKeyList): integer;
var
  i:integer;
  aKey: TKey;
  modifiers: integer;
begin
  result := 0;
  if (aKeyList <> nil) then
  begin
    for i := 0 to aKeyList.Count - 1 do
    begin
      aKey := aKeyList[i];
      if (aKey <> nil) then
      begin
        inc(result);
        modifiers := CountModifiers(aKey.Modifiers);
        result := result + (modifiers * 2);
      end;
    end;
  end;
end;

function TKeyService.CountAllKeystrokes: integer;
var
  layerIdx, keyIdx, i:integer;
  keystrokes: integer;
  aKbKey: TKBKey;
begin
  keystrokes := 0;
  if IsGen2Device(GApplication) then
  begin
    for i := 0 to FMacros.Count - 1 do
      keystrokes += CountKeystrokes(TKeyList(FMacros[i]));
  end
  else
  begin
    for layerIdx := 0 to FKBLayers.Count - 1 do
    begin
      for keyIdx := 0 to FKBLayers[layerIdx].KBKeyList.Count - 1 do
      begin
        aKbKey := FKBLayers[layerIdx].KBKeyList[keyIdx];
        if (aKbKey.IsMacro) then
        begin
          keystrokes += CountKeystrokes(aKbKey.Macro1);
          keystrokes += CountKeystrokes(aKbKey.Macro2);
          keystrokes += CountKeystrokes(aKbKey.Macro3);
          keystrokes += CountKeystrokes(aKbKey.Macro4);
          keystrokes += CountKeystrokes(aKbKey.Macro5);
        end;
      end;
    end;
  end;
  result := keystrokes;
end;

function TKeyService.AddMacro(key: word; layerIdx: integer): integer;
var
  aMacro: TKeyList;
begin
  aMacro := TKeyList.Create;
  aMacro.TriggerKey := key;
  aMacro.LayerIdx := layerIdx;
  aMacro.IsNew := true;
  FMacros.Add(aMacro);

  //Return Index of macro
  result := FMacros.Count - 1;
end;

function TKeyService.AddCopiedMacro(copiedMacro: TKeyList; key: word; layerIdx: integer): integer;
begin
  copiedMacro.TriggerKey := key;
  copiedMacro.LayerIdx := layerIdx;
  copiedMacro.IsNew := true;
  FMacros.Add(copiedMacro);

  //Return Index of macro
  result := FMacros.Count - 1;
end;

function TKeyService.GetMacro(keyIdx: integer): TKeyList;
begin
  if (FMacros.Count > keyIdx) then
    result := TKeyList(FMacros[keyIdx])
  else
    result := nil;
end;

procedure TKeyService.RemoveLastMacro;
begin
  if (FMacros.Count > 0) then
    FMacros.Delete(FMacros.Count - 1);
end;

procedure TKeyService.RemoveMacro(macro: TKeyList);
begin
  FMacros.Remove(macro);
end;

procedure TKeyService.RemoveAllMacros;
begin
  FMacros.Clear;
end;

procedure TKeyService.LoadConfigKeys;
begin
  if ((FConfigKeys <> nil) and (FConfigKeys.Count > 0)) then
    FConfigKeys.Clear;
  FConfigKeys := GetConfigKeys;
end;

function TKeyService.GetModifierValues(aKey: TKey): string;
begin
  Result := '';
  if aKey <> nil then
  begin
    if aKey.Modifiers <> '' then
    begin
        if Pos(SHIFT_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_SHIFT).Value + '+';
        if Pos(L_SHIFT_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_LSHIFT).Value + '+';
        if Pos(R_SHIFT_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_RSHIFT).Value + '+';
        if Pos(CTRL_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_CONTROL).Value + '+';
        if Pos(L_CTRL_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_LCONTROL).Value + '+';
        if Pos(R_CTRL_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_RCONTROL).Value + '+';
        if Pos(ALT_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_MENU).Value + '+';
        if Pos(L_ALT_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_LMENU).Value + '+';
        if Pos(R_ALT_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_RMENU).Value + '+';
        if Pos(WIN_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_LWIN).Value + '+';
        if Pos(L_WIN_MOD, string(aKey.Modifiers)) <> 0 then
          Result := Result + FindKeyConfig(VK_LWIN).Value + '+';
    end;
  end;
end;

end.

