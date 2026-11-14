import 'package:regional_packs/regional_packs.dart';
import 'package:test/test.dart';

void main() {
  const nom = NomConductors();

  group('NOM-001-SEDE-2012: conductores', () {
    test('calibres en orden y valores de tabla', () {
      final cu = nom.sizes(WireMaterial.copper);
      expect(cu.first.label, '14 AWG');
      expect(cu.last.label, '4/0 AWG');
      for (var i = 1; i < cu.length; i++) {
        expect(cu[i].areaMm2, greaterThan(cu[i - 1].areaMm2));
        expect(
          cu[i].resistanceOhmPerKm,
          lessThan(cu[i - 1].resistanceOhmPerKm),
        );
      }
      final ten = cu.firstWhere((c) => c.label == '10 AWG');
      expect((ten.ampacity75C, ten.ampacity90C), (35, 40));
      expect(ten.resistanceOhmPerKm, 4.07);
      final al = nom.sizes(WireMaterial.aluminum);
      expect(al.first.label, '12 AWG');
      expect(nom.name, contains('NOM-001'));
    });

    test('factores de temperatura y agrupamiento', () {
      expect(nom.temperatureFactor(30, 75), 1);
      expect(nom.temperatureFactor(43, 90), 0.87);
      expect(nom.temperatureFactor(43, 75), 0.82);
      expect(nom.temperatureFactor(78, 75), 0);
      expect(nom.temperatureFactor(100, 90), 0);
      expect(nom.fillFactor(2), 1);
      expect(nom.fillFactor(4), 0.8);
      expect(nom.fillFactor(8), 0.7);
      expect(nom.fillFactor(12), 0.5);
      expect(nom.fillFactor(25), 0.45);
      expect(nom.fillFactor(35), 0.4);
      expect(nom.fillFactor(50), 0.35);
    });

    test('tubo en azotea al sol suma temperatura', () {
      expect(nom.racewayAdderC(RacewayType.rooftopUnder13mm), 33);
      expect(nom.racewayAdderC(RacewayType.rooftop13to90mm), 22);
      expect(nom.racewayAdderC(RacewayType.rooftop90to300mm), 17);
      expect(nom.racewayAdderC(RacewayType.rooftop300to900mm), 14);
      expect(nom.racewayAdderC(RacewayType.buried), 0);
    });

    test('ampacidad corregida: 10 AWG en azotea a 35 °C + 22 °C', () {
      final ten = nom
          .sizes(WireMaterial.copper)
          .firstWhere((c) => c.label == '10 AWG');
      // 57 °C → factor 90 °C = 0.71; 40 × 0.71 × 0.8 (4 conductores) = 22.7.
      final a = nom.correctedAmpacity(
        ten,
        ambientC: 35,
        raceway: RacewayType.rooftop13to90mm,
        currentCarryingConductors: 4,
      );
      expect(a, closeTo(22.72, 1e-9));
      // A la sombra manda la columna de 75 °C (terminales): 35 A.
      expect(
        nom.correctedAmpacity(
          ten,
          ambientC: 25,
          raceway: RacewayType.indoorConduit,
          currentCarryingConductors: 2,
        ),
        35,
      );
    });
  });

  group('NOM-001-SEDE-2012: protecciones y viento', () {
    test('capacidades y tierra', () {
      expect(NomProtections.breakerRatingsA.first, 15);
      expect(NomProtections.pvFuseRatingsA, contains(15));
      expect(NomProtections.groundingCopper[2], (60, '10 AWG'));
      expect(NomProtections.groundingAluminum.first.$2, '12 AWG');
      expect(NomProtections.residentialMaxVoltage, 600);
    });

    test('velocidad regional de referencia', () {
      expect(MexicoWindSpeeds.find('monterrey')?.kmh, 143);
      expect(MexicoWindSpeeds.find('Querétaro')?.state, 'Querétaro');
      expect(MexicoWindSpeeds.find('Mérida  ')?.kmh, 160);
      expect(MexicoWindSpeeds.find('Atlantis'), isNull);
      expect(MexicoWindSpeeds.defaultKmh, 140);
      expect(MexicoWindSpeeds.source, contains('CFE'));
    });
  });
}
