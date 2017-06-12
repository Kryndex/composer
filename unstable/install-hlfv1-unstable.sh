ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1-unstable.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1-unstable.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -e

# Docker stop function
function stop()
{
P1=$(docker ps -q)
if [ "${P1}" != "" ]; then
  echo "Killing all running containers"  &2> /dev/null
  docker kill ${P1}
fi

P2=$(docker ps -aq)
if [ "${P2}" != "" ]; then
  echo "Removing all containers"  &2> /dev/null
  docker rm ${P2} -f
fi
}

if [ "$1" == "stop" ]; then
 echo "Stopping all Docker containers" >&2
 stop
 exit 0
fi

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data-unstable"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# stop all the docker containers
stop



# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh
./fabric-dev-servers/createComposerProfile.sh

# Start all composer
docker-compose -p composer -f docker-compose-playground-unstable.yml up -d
# copy over pre-imported admin credentials
cd fabric-dev-servers/fabric-scripts/hlfv1/composer/creds
docker exec composer mkdir /home/composer/.hfc-key-store
tar -cv * | docker exec -i composer tar x -C /home/composer/.hfc-key-store

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

# Open the playground in a web browser.
case "$(uname)" in
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

echo
echo "--------------------------------------------------------------------------------------"
echo "Hyperledger Fabric and Hyperledger Composer installed, and Composer Playground launched"
echo "Please use 'composer.sh' to re-start"

# removing instalation image
rm "${DIR}"/install-hlfv1-unstable.sh

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� ?�>Y �<K���u��~f��zVF���Y�j&��^5?�vOfa��>�����dLQ%�E�IJ�4cs�Ň�O9��%9�!@n��9�%AN�\rR$�jI������^=�[Tի�^U�룶&������(�+�kh#���%��;*��$�H$�|R�0��� 
ӷ� �˨0I�o�4��܂���^F����,C���x����������!� cYB�> �u�����7�e/Tq���n�<���7Ց��v�q��J����F���hC�cd��w�=tː:�M"�:F�rB>W�/�\6�N�����\<A�Ǣ�H�p��֑d��W00NO�-C�N��:�����u�62%C�b��0�6�cj�<��s�c�t� M��R�4��"z�-���u� F	�.��tE��D�*�n�$y
IV�� � ��ь62�^��gku�c��nd(��]C��	bN�܏�aҿ�ͫ����z"�I��pz������q'gt)��?�!��[���DW��i4]��:!Ӫ���Pr����EC4ƪ}F�����D��rQW��:[��ygծ��/��YɢrI��Cٵ;�A��g3'O*�l��.��:�H�;4����ʱ�Y�o/�����_x�h�q�q�� �7��	��h�����"����[$�"�[0��%� ����a�-$m�VE����ٻw��g�?�����G���sA7�����M��O���-��p�L);#�͞��-8��jh��.D����vO�B,��D�� O=������M8z�|��_�W~��S����O�*v�H�iП���"f{������
K�#Eq�����ӥ:2fN�2���gr/:�<f���a���}�bb1���Y�	E��X����Y�D�9�c�������{m_'��H�$�G �n�=�_�?�=R5����i��'�<r>�ϩR8�Ϭi��*SwP��x�No@_�\�q�uj��hb��{?'��
#�r9��5�8�zx�<�/���
MM��wh�d�57Ň�C?�ͧ�\��;��?u��1�;������T���Lۜ��?����ު��]�E����kRO lH<yr���y��͓�\�0��ּ��ښ�~G�-�6�G�<s�n���9�ho�'L��T(��H�m��M�r�7��!!�A��~�e�yrܗ��(�*E�Fb��P����x�^'Sܺ��*�`�Ǒ�����4DG�����o6����k������F`k��lؘ����&_ γ� E����ppk�7o����x���
D�=UB��#V����&�ʏ	/�J�^�����%�:^śo�_�\:���}�����o6l����|C<α*DG��?�}����H�h�Mw[y;3��&��g�GY��q�bM�1܃ICly4#�p(`��$K3�ઙ@9�.�(q�t���'�7�y3�����Nq�3����%�W�܍����`�b�{Q勥t.�3yu�e6��ZA��	G���Ϡh�����;���'΁5�����$@��Φ�):[��Vaa������L�����\�|��+h�d����d��ǧ����)����	���?yF����w�a?�Ϟ��?�)�o ��9\lG�Kg����E���-d����'����Θ����]A��"K��8O�M¿�ſ�E�oN�������<.�'J�����M����z�ki�y�������$Em��F���M���?	��?S���&`���DaM�1�0-�C3>��!��;5�8��N�������3AL��Y�����I�)����Y�����c���9O��+_`�s�X�q.¸'l~������u6�ϳ���?�n��F�+��k�}~4?h�]��"Zh�C��;����|:���#͵ڹʰ?�E^DBj��%�����I�UIH_�����U8j#��nmjy��_����)|��G�������w#�k��}gmʩ1�������c�����\ّ�r�x��I��`/�C0:�����ɭĀ>���ٖ��"���#>u84��q�Gل�fCIA��������W�>o�7Z��t�ڮ�������M����k�Wl;�a��������z.biе�&���~���	�RwZ�t�X��gظ�z��+��p��M?�V�7/����~f-��s�y����:�^A]dQh�$����@���a@�+�|a@����ΰȒ��[�jG�Zb��kMi4y���%�Ε���Nﶰ+��p0��Jݪ�~R�iS��;.��vsEx�\�
��~w������5/��vq�_���!r��wp��_6��ps��Y��A������hx�o���KP����wo���O���_��?nQ:J����aO��V8�D�A:�
�(�'�C�H�C��P,ҦBR��BRP�C���2,�G?���?���!���߼��_���/_��?�����2N���E���~�^�󸾿����G ̿
���_t�>�v������~��J�߽p���,��b9�HsL�wK��N�R�㘢�e�4��8f�ks�F:�5ӳ>��2;��+�N2T�[��A�~� i�7m�;Փ�BY��~��;���[�]-�35�X��n#^-� �XciXT�auZ�B�m
��d�Gɒ�c�|����6�b�4�fb�1l�GF@g�*\n'N�:�mҽ�t�F��I)A�R���Z�YA�Y�a��55�2�E�Ҥ�I�A��������>{��6o�,a��`�N�c
��,v�̱l�OpUq0�	/ebzC�);�3Ѥ(�6�Iۅ����1�&\ 0ڢ�,#p�e�¥ܰލ����D/v��.��*�fHv�{8hT{Z̚���Mws�)�&�͚�feD�G{�p���D.�7�&Nh���� >?���}���2e�4m�S�n���BGi��k�:��P#Δ��d��"5��!����$�'pժ0�gL��f��R�d{��2�6k�$�g*^�T�Wq��&�4L��2kбI"Δ<���X��)Vͼ4�&˚��'�\M+3(a��쌙	q
t6�q��M���(��	7c<F�2`�jY(
6_p��y[�7j�9ܛ��JO(6��֥x�*7j�nQ=赆Y]��c�$ZfY4O�%k�k�Q�)�+��\��f�nw�,������-��QW�u��K�h�0w�A�'�1��� HŬ^�ר��zd�ΚE62&Ƽ�R#\�_I�YF���^;=�փb��kT̮���3 U�9���*+6������f��yf�L�AN��K
)B�I�H�[�Y�͖TIN��f���hJ|�˧f�8��8������5mc���L渻 ���fSL���#�('Nv�KM#��P�Ƈ�DӴٖjr��Qk��L��1�.�2���&�V5;������G\_Dщ�8�)�3�T�d��zc9�ö⎇ͼ���3�(0�c���Uw��%�+�Jޛ	<6q�g�f�2����N�TQ��I�aA&�a���^)��,n�Ք��11�pT�	�`��v��:���I��`�W���W�JP�r�5Q��
E����`A6n%KbL�,qʳ�!���+8�Y�Qr�HL����:�#a��M�˴�r�y�LD��P��f��y襂^�ڣ��fc�Sfپ���8���J���#�X!���¿!e)_@Y��Ne<Mt��a�H22�M�tv �Bu֥��֣IM�Uv��Z"�N��*����0��3=Rl��d��ԧ0le.�,LA�f]�$�� �B�)�J����!����,)#��#�I��%8s�҂Z�����(���!�p(��U��S���Rzp�P���%�(U�U���ёt�7�::�t�^eIoR��e��^Y�P�T0m�B�b�R5�H�Qt��ޔ
fgt�;���J�Q�����ffl��=U��*Vv�nv�Át�y*��Y�e��)���Jz�d�Ac���\8Yȓ�RS*P��ey�Le)�w��,C��h���0��`O˂]��N井p9K
��.(���bE�����)�H���z�r�'6��4K�r�Ѡ�:e�os�mζ��.���}�q~,���{5C��a��>��-�]�m߻��۷�~������Q̟|�� ���R�;������2�"r�\���O�wYђz��Sj#����=�&���������"KS�|��3��t�Q����8oM��Lːݽ7�w{���8\�Tsd��:����65E[�����4%y�|����mp�/~I}��p�M�bp>�}p��>p���[�O��Yga�**rە�����a��ӱDo1l�y�2��,�E����;����~���o>ga���L߯|w)��J=��;�|���> �㮱��Y������ŀ�ه����������9��})ؾ\�����)'tK���]���K�q��r{U���'^�u�}�+Lp^�K��A�2��f�h�
��0�Z����(�5�-xa~"d+tb��SШ��b=�o-�#���ۄ/{Ah�K��"���:�����J��Y��Z=^N�4ۋ2����D\&�XN4��n��,֒A�v�>��De�aH�p�h��Q�z"l�ĤK�����w-1�dg9Aje��L���so�_7L��*�����\�]��v�^��X�aB�!EH�X %k�X!��D	��FB��a�ʯ���rOw�&}��{]��Tթ������?���YV�U�N�C/�~�E4�Ķ�Fu����
*��~�Z�K�p�n�iG�R�ʂ7T�X6eq�|�m.�,9���F�?�ֵ��<Q�[�nb�qERR��Ìxh"���ˋ!c!�~j���V1��(�,�rf�4���@F�,�� oڜ&hFt��n;Ԣԉ,fsg�OXs�p��o���:*����"e�@Lw� kR��0޸�r*nN1�;;���s��:�=r,r%%}�쫞P�K;��۾<�Lv���L��Jv�}�K���_<{{{Õ̻���{%,�����翿u���"aK�O�%���H~�8�u���Fkn���r�!�9sЀ|V~Z���`����[Y�͙�Í"ܞQdc�k��
ZEv��ӳf�㡲4�\��@�Ɛ�7H1��`�l�Q�;�c��6�G��J����L�$אӀ���4
wD'�ζ�i>�Q2��f�hBiHry�r�k����i�C��Tg��V�c���O$�"*#��t���`���I"[[�W�(�Vj�1kP���"��K�6_�-b\Ȧ�Ĭ �p�DT#n�g�!&-Z�T���E�#Z�tj�j16�L��jW��I$,�9@�xi��(�۷�=H(Î���x���A&����{��4ۉ�X�5���&�x2ZZ��?_�I��ڢ���t��J�K���G�ɿ��~(�m��'4{gggoA?��9���� ��R����ϒW_8����m��W�ֳ�ǿ�����?��o��?��G�����|�����_?�9���kˢ�:<���>�����=j8��Mz�|�;���į���P����ο����o�ӏ~��_������&���|�?~��?�� �����ٟ'��%�?KB4��[������]������қZ��2��;��O�����������?t��'�gN������w��-}�8���ٿ�v����O�];\;�k'p�n�M �v�Yܰ���40H�N��	\;��d�0�v�o�?�7�p�|�(}E�M���)�g:g_��!ts�8�>����C7e|��ל?��g�&��� ����T0�
�@� ��d~��|��@�[���e6�IZ`����53`Y X �̀�:G kf���K`�X��ͧ6�aZ{����:�>�3�S��n�-�s�? ������q��}����(B����S8��H��G@�k�e�/�?�>� �	�tӹ���u�Xn��X���b,7��O[#��o(y����&���]�iUzsz��uS\���v���G��τ���s����N�����g��q���μ�������a����j���C�y���z`�V���c0Y�uMG��Z�I�	��M�B-�Y��-G�%Pa��"B�,J�$Ii�NǏ���z��w�~�#��`jw'=s��^��h>�׾B��� g�]�����uy�7`���_x��r�0���Xuc���{�����ڶ�9Q�I�˘��r\�2��R�Ŝ�ϿA^/�ܚ���+yU*�i�_��%�*�Z�6���^�g6-pIO�Q�7W����C�����Ko}@!���ʆOJ޷j˝K�H��)%O�LH�÷����m��)�r�vDӻ��ow>-�N.��7�~�����z�c��~^����M��eV]{���K�5�8���n�m܄��7<QqR�w�����ږ�vO^cB_\��7��������%�g��+�	��$�9�;�>Dox�n��^�,��ay�n�m��[�AH�KA攔��K�"	ł��R��%���)�Rx��������1�VR�7�~kv�p�v��T��I-�vv;��Ό�[�k_}��%��\~y�꓇/_��c��:tC"﬐NE�X�+�7Ӄ���[c�|^�\�s���y���|lHuU�^Do�W�R.�%�Ew�M��~��.o&`��^'��{}
����ٿ{I9�<��������ڮ��c���__4qΗ�gt�0ww7�W�9^��>�� �[���ا�s�Y&Y��6Ms<8^��Z��z�$}�Y����f���A��B��N9�/�ڐ�
�t.�z=��F�4LK�tǟ���yn�)F�/����y�~ղ�vZ�!��M����o��m����ğ�>���F����6���,�a��o8��������fS�v6E���&	-��Fh�t�>�No�	�)����)u@��g�N�OE��+9�Ԇ��p��o�z���"H�?�OY����w]�8�a�� ������w_�(�b�������jx��q|���������I��H����qy4v���u}�AIz�- (J!�'�)?{���ȶ�w����g������S-�uQ���! ��P�?��?
�?��s��	�� �?��S�?F��O�'��u���fNi�Nh(M�(M�u��pCg�2�n�&M��ku�"uEL¼t����0�����"N������US� ���yB���Nɺ�e%IQ{�4#��r%a^������Y�Żt)3��Z���Y�K~�bV�68�֪W�Ɉn�I�S���E{D%��r���t�՜F�H�1+*PqmK&Q�F�JwAF��)��E)�_4�H����[>��R�a�Gi�p���������;Ǎ� ��/{��c��G�4�� p2�?XZu�x����8v����� ���f��7E�8u�a��P=��1 ��`�?8���	@���_�Co����@p*��;l 'C(���� ��O����4뽫�䩆A6\91K͇��xJ vF�.>�
�1�ɣ�S�'_]�V�B��U���hǕܪ�.4��nP��v�:v���l9t0]��Zj�s��RU��a�yΏ^n�_��g��J#wb�-Fy׻Ĺ�:��r��X�.o�B�Ul��%ʋ�#��+Vz4��PZ�3�L�gKB�E�ne%Ke�z�s.��8����W�&��4fQ��5{ ��4��܎����1��TA��sS�L���;|����J$;h��-4��P��ʃq{���u�A�C��?0����th����_����Ѓ�?$M ���0��B���'����`����� ����C��
�����/[����'C����������A����D�O�m�$��Ei��[�p�d��u��)�"�h\g0��SeZ:JZ��VX�4@��'B� ��	qD�!����Z2��n��e1�w�FU���"��:�'jg��5��X)L�i�j��f-��RV�2n����rd0)#��Č�K���z4�T�9��:���C����D��,�2@�٤�h����X�a��?N�`��#l ������� ���p2�.@�@�?��sB �����������@�����/[�����é��<�����A����a�?Z[�?ӮSxOL&Baj�=�9��?��������:�gK�\e��g�-��W������ U�wS��f� fЌdZ�N��1J\^�wfu�G��!I����֍�d�mE(h�t�سL����]����~�Qzs��1?<�^��Y�W�%_��5ΏH��]�sW�9�*�٢�_����*`��r"7Z�T).r�� V�L­7����>CMeV!������q!���f��-i�k���R8��r-����x���N��ͻP��`��8���,��km5^ͦ+�\CP�d)5�RI�^ԭ(|U�N"��HG p��]�_��a��@���!X��������0�?��q:�����X
����`�������kx>�׵��w���a4	�� ��9���1?���!�S��  � ������a��0��_�A�Y����:�k:Zg0ԢL�N0�njj��n�8�0,���0u��dQ�%IJQ>�A��=��M�?p�2����?RL#-	��0�V�r��ԲL�kO��Q��r_d狌�%�[����7\;��U.D�Joڴ��[V0��lM�Xa�&�iQ���ΈHi�㐘�ZŸ[6�f�(�����l��?�O���a��S��wo�Ch���s����U����Gq����U<��z"<w�_���"��?��	�_����
��)��}"��;'ׇ`;� �?��S�?��������?��� ���������3 ���Y�Y�a1�b�z]�H��(�Bu�B�`YL30ˠ�u��-�%˪�˰&
&�������_����_ 8b�7�����U%�1Pi@͊�D�8ƞ�|�V�cDFMw|���H:�ODr������j�#47�$#�^�-.���s��,�V=W5!1G
���f�8ME	ϊ�z���Vlk90��h�a����/��?����`;���/{���$��x"���w.��b"�J���y��?���%��_��Y���b��V��XKTE�P�ǔU�@��,ڈ�pȭ��$tӊ�cTA{E.�J`���b��բ��+56���S�����Z���̨��Rn�����b)1�y��޹��ַ��Xu&,���E��uK5���j)�"��Z�j=v^�u�j��F��5Yr�B�L4r�x��Kt,5�v�����*gRQ�eq35�E����Ҷe�H�� ��T^+L�;��DE���ȉ�p[�����̸�jV�FG�P��rr<5��RW�SB�]�)�5�W\�Pt��b��[)�bDB�A"9��Z���p�FU�9q��MΩ���LV�U������/�|_oEsZ�V+(�tF^X"�&+$9�Lx�M��N|Hh R�D^�Z�FuhA�ET]���i�49����������JE�S朳 yQ��vi��2Q7J�����Lz֯#�rבk]5-���`���@�������� ��˖�B��W׀�0B��7\f� 
�� ����`��@��/�m��Z�ð�x����,ZJ�*Y��_zO�e�(�Ey�6����M ��Ɓ)_�=�l�k��d��6Y���-��q�~�Ά�´���#2:��S4*����g���*v���������v�{fwv����_����S�~w��TWWWWwuUMU�s�Ȁ!��B�#
�D|X	� ����Ȗ"�Q�8B>�V?�{�ݣ��
�]����su�9�:��{�h�52F���\2��i�:�j;𛑖� 9���iF=�M�(Ϡ�`��q�JM˧��y�A��B�~��s�������8A�=(�*�f����P��^3���d�cD��N$M5�{����B�x�}h�v{�|��h��"�9�b24�ǽ����?�
��y��{�祤����A<�d�����B�S'��������P������C��o��X��������|����G�@���Sn�����H��Oz�����KJ����v��˘�������KI��o����������E��=�t	�?ݠ9���"ݤ�W���4��
>���h��$������@�uw�/x�� 8=<��}.ʾ�L�1���'��`�l��Ok���$J.��G%���D>�Œ��Y�`�� :�f�O���?
�nǫ�I��JG�hz��f4���ӤGlcH$�P���jr�χ��,�T��ܻb�&�B6��H_��O�~��!��M+�.p��J���6%Y�7Z��q������e��
�$�����_"�B�9�����P2qU���n����~�tI1qN�q�
t9�a�C0�=������&�s��l�@k�"�h-��&�2����&��F{��n��'D�s��)�^S��)��4$��V�𜉿�:NG�7V归���*��ar�#Mp��;, ǭI�̿~�ʁ�������������R�U���t�w-з�m�լijGA�Y7�V��>�;�'@{�as	�)�Ά<�"��
�c������ۯo��%<Aj)qr����;�t2|�%�0Ʒ88�2�f?�e]C��P	RQ���,�!h�:*s�Y��V��9+����IX�HZ@�[*�A
�e�!Bʝ����-��날L���7U7[�X+b�^�O�;qI��I��G�v�(���q�cZ����H'E����Hk��D<�����Ϟ��H��ɧ��4���y����� [���t\u�p�Ss�������3��5���HNk\u(�dY�� i�\E���X^lQ��J�@��[�:�4�����/N�Z�{���]xV��7�X��B�AO���?W����J}���.����4M�6�_F�O���ƣ[W6��?_���W��{��:�ty����'a�s~���)o��\���(?��fIq��AҼ��i��aEZ�p�r�c�?g~��S��ί>���ޣw���+o�������c�g��,�����X�����D a��~�" ӟP~`ｸ��/�O��w_�~��k/,���c�85|;dr�ĩ9����1f�����90q�1�X�O%� َ��� �6�Yy�r^�)/�'A�9��|�����/߇���:�`z7D�	W<Us�z��2�������A=7��e3�-��aM;>O�����>h���Re\�|�v�����2�x��"'^���ל]���#�����0̳>��l���e�\��Ln����d�cf�'��3n{�V�P>W�|g7S���\��R�P�b�S-���2ME��iz�Ԩ�A�)㠪�*�q���w�Y=�i��]�L�P�g9��o^�=�'�����	Ǿy������eϔ��q8�d|3	�%k����Rex27!�5 ��:���� �I����.& Xw�q&��|Z��A�Ʒ*14�۫�R� U,E(��*���4��LEZ�p��q�K)9�lp=�Ɏ{���e��B@*dF�O��qL�^��
VpL�2��.QC�A�	��1zTM���T�%�o��r>�p3R�Z>���F�3�q�o溩@;YO%�A�,��Y��y��l4�`�%|���������("FjՄ��Y�G^W���li,��� HU�Y^��K�^p\�He��¾JFiu�@9���\C�D�bM5A�ήG,LVN����F��r�	�d2�ɖ��"g���%�S�%��L�SR9�84�B<��9�_4|>�ً��Nt�-���e4nV��ØFd@g�Q�K��ZiPn�]�x�5�Z�,��O"��	�2<�X�+K���,K2�DE"./���Tj�J����-��>7��r��0����aF�Uԃâ�7jM.��)W���*Ԕk=b	�ҒE7��k*H��ٌ3���Y��^�=�X��]�=�����KäX�E"9���W���XtR�d��K���nG�=������K�ܦǭh!��jQr�r��J��=�X��f�l�ζ�ζu�A�m
<Q�%S�l{a�l������n|b�)�S����J4�>a71�~n��&��b��G��	\c���^�
p&�BN6�gb�`O��]ngט���
"��*U���,�x��yA3Y�dn��Nl
9�0u�����BWOa��=�0�l�3TY��8�Uk4yi,`�Ʈm�ͷ��6y�����k:�ȹ�=��I�~o>:��	��*�)q�԰F�}{_�O�B{s��a��0�Y<��ۯ�k��A\L:|��{2�XfX�;�	����^��u ���(����w�Ln��w��/?3���d��&���ڳ?
쏂�?
�9w�<��<�T"A��o�}�@�_R����p��1�<6'�`+9'Gt�X�0Y4�C�by���
X�����f���c�QK�X�C���y�=`�!RB*ܥ�l���]�3�D�:�E5_���}*�G+F����Q0���S�_!�|D�VKT	*��v2m�UO�24�m�rh�H�6���� �CL4 ��33���D���d����xJ�� �`��N�c�C_��VRc_2+#�N���E<9�T:<����W��j��I�p��B�mxƥ��x82�T�/�A\(-� z�� ��}�|�>v�����dT��@���9l氙�=�yOKz�,T*?��\^C��T1Y�1әV�A�5�m�y��B�'�k�
�tޙ��:W�rm����3��_o��a�.Eò-i�,i�."��ש�i��at>���}nn�;F@H*�_�Ƚ�bI*�N��mF �E�%���&.j��
L�"��Z���z?�xW�l��]-�ke��D+	ȣ@4�aȖ�1x]q��l�P�QD �*�jN�'�DM�G�N�`]t�Q��8<=1"W��$ñ�1�-�k�g	���
�>��W�
f�>�Ųt��9S�IR�6�N?�U $1��Z�+*z�Ұ�3&-��rmu�l�d������E$�8P����+<�Z��!�N@�r�����h��O3N�]��g����e3��7�XK�q-[�VR�\k+eK5V0}�d�[�̶����v!��b�ђ1o�=��閵p�azz|sj�d]0��X{<9��tZ��s�W��QFU�
�.�a�J>Ƹܞ�m\	+/���!��x{��\���Ȯ|��><P���ϐ������x�?^���������]E�;p��=>�x7;-���U�EcJ��u�!g�qn�'u4������KI����[���o%����ڟ��/b�\{3�웿�쿽��_��a��^y���F�nx�s� y���V��5:η8I��v�G�_x�K���K���?����Gn����͟�:�C|�b��b����]��rh���N;������0;����>�^\� m���N;����u6[g{B;׎���xЛkU��׃����⺂�}����Y��z���90t�c����+��	�av�����q�+�v��q6s�����.#y����f�+_,l�9MӲ����V{ό�-��`��f�K�3s����s;sn�o3���U�6?�����y��K�� �����C�.��V%eovh{��ȳ�?I��!����q�񟗑�� ��'$^P�����֩����ϴ�^����ap�;���9n����=�ˍpE5�!�6$���H�b]� K�L{| Ŧ�ϴ�}�FuچZ79�����" ΙAO���5�}U	yf�x0�ʇ�������*�N��t����M\$u8L�઎s�.�2SE@	��-�P����LCBN�z�\��lx� �8w0y<�w�&��B���X�X��L.Ǥ
�pO��`:������Tg��-\�؂�C-h�¤аЖ��!�.04���_M{�(�
9\�o�k�ޕ4�`5#K]ɜ\�t��PG �hj'>��� �8٦$�_�aug�ކ4��4��B�=+k�%M��oo�]��P<�B0V�V�_�=Y<D�b�:@1N���R',(�fU�^tv�Pa�b�]g
4�f�Cq��#��'��i{��� ���=��E���gsx[j,�(*b�Ŝ�0��Ā�S���w��#Wf�fr*�!���8�Y����5���D�LX9;ۋ��|�p��;���f�������|��%����.r��l������x��6(5�I�7�׏���s�F�:�>����}4��۷�{���o�����M���}I+���������X�,�7% j�b���rwq�i:�ڀs������õ�<��	��y4����I3y�D�	�l�wk���ĳ^`:7����s]����B)"��V�)O�|'��P.w����=e����u���8�>�������dy"m ��@U.��/�%4ϩ�j� ����j ��O��h�zu�ڂ�X�"g�C����LLI���)�>��B	v�#�B'�y}.������747��0p�o��e��T�� p�؇��@$��=is�Ȓ�_�����6H���l��l����g����������VV�@-�p�Ąi���U��g��^��h1��w%v�5|��Vi�����S���srb�$@���C������D� �lj������36�;E���S�����B�| �> �d�u=����qL�x}h��5�������ԑ۞�9-ޙ��y�e)>�l�����&��]�sA��$�_��򴼑�W���-8d�'�]���ρ����d���YP���n�믿8>��} ,�^x�$.�����n�`z!�Z��Tq����x�܇��`���- ���z�N���Hҋ/�ė; ��JXQ�#k�����y'��a�u���lY3�Q���m��o�H�6�����U�椁?65���vW�P��A�|����.������E�����3��Ic?�$׭ݞ�ȟ���,�`�<���P }E���hO5p����[p�ȶL�p���1�kg'@�ǁ�-��u���)\�"�'ћ�o�[9
v�]�f�Y�q�;��IX|����e3���"!#|w^$�2�(2�;Ci�2h��E��{�)}���^p���7�[�En���gҙ(� ����E�b�mͰ~�����YXQ��V�1z
 �Ե���1�qt>��ʵ�s�;E����~���\�A����������[�ig�1�\�1M���"i�/!�4�n>+�t�
i���a�V<��A��a�K�~{��z����@P����"*@���Q�x9^��
�����`�F%�
�(�S=qkiL�!/�}�NX�H�S�a�2#tG�J�Y�e��?�I�7��Y��1~'��K9)����c��e�ߟ���&�{`��:zU�@)�>�PCMo��|<�,��:�!O����^�Z�iס�O�NEn��4Y=��PZwW�ދ�D�{�?Ґ�_u��"�?x��%����I|�|]
I�mh(�X`�ᕣ*�&}�M���dwR��8I]�	<9�;��8l��R͂�3B|�4)�\u�#���v��5��K�����G�>	�_�[�s�A�����P�F�2�P��kRvg������%̛1���ŭɡ&S�S��%���A1)�@�̬��$���4k
�`���{�� �n����~ΐ�X��/(��t<ru�P?�;��9Ɨ��?�јTܾ��3-U1!e�$�O���삫DF����2��+���B��~6N,R��:��e�fԝpm��~��O����)<�=@��S?�'�Jnz�.�	�x��Dp;���jT�sH�#/!]-!w�^���&��i��p)�e"M��m8HU'r5�D�O�)K���Lϟ)w0D�?]
I��/w|K���$�N�������Wq� �(t������Q�
mIk+˦�<)�7��}��"I�����F���)ȳ`K�p@��#�b�8¯/�Z�*���ًu%���K���/���ܤ���X5��6i�����	����j���×C�	.DX?Ā	��KzBI��	�N������e>�? 1�x�w�I��_$�U��
��y�Rtd1��P�e=[�L�tF���)Ż�+"�KH��_:�?!�mY�H8z��4�,��nv1W�ᘡxDa�\6Z�$�`7z���!�E��r9D��Wmۆ�:(zGpN>S�X=��� ?��7c�x��AR��H)��t�{V�N�7���g8Id��=S��z�"&����d�st$��U�ٻ	U?�ٕ�p���/�;�$KY�$���T���H7�a�*�̐��U�x@A
�dp�� �����N��� iH��ݭ{akp�_�&=4��d��q/�aد�g�V2�w#s�xN�@�exК�N�6?�u%��6��IR}���4������ic��6t^�|J�#Z~���G�8K�^�-^�#�[����	HJ�N��x���	H!�[(��xC��8r�yr����;�?)˧����$��_ �|�Ő@�!�F�+�dc�B#]�bW\'>�n���>�0���E�?0D#���W�Cq;�t�ɷ�	~����3:wo�팆���Q)����֗�z*�=bIw���΄S$.Lgf!��U}t�Iѧ���"�'���|�<��R�˧� 8��9�ȅ���~s�=~�u!�^��&{�~��ԁ\�C���ĉ���/E�[�Q��C�`��f����Y�416�=~HC�f*����k^�L�� ���'��Ǧa�;6e�5�����`܄��W�pν55ud��w�%���kK���R�w�ᵋV���~0v�[89��'<�#B�>qT����ę��F�1�H��;>Z V+�C2f�i��]GJ�o[�!�)�AEnuDQ�^� q$�
����)�Q�(�?!��'����!����(���,;���
�/��y��M�Z$�L��U������c�OT6�h�)Z�E4L�#�!k[�`rn^���g�q��M��H��&,)r8��gb�!ճR������OդfS�� ��gة�HR��Z�S4����xb����į֩碐B�WVJ�2b�.~O��I%�`>���?�r3af����P�1@�)ClN��ڊ� �M��fܕ_eӥ����]o_�U;����b�ҾS�?Y91+��~�N<r�0�!'�z�!,�r���^Y��[.�
�u�Aƚ(��ڝ�o���=G��N�a� /�^�2�Y�&%�ߋ�	z�������	��.z+��\7��y��?9���|z̻T�f'�C�Xz}�&�5�z\��a��p:��r;O�	� ���]a����r9��Pdf8�%�Έ{��,={�$O}��#ˁ6����s�Fwr|VX����)��vZ�'-C�yf�eY�Yf��!����/Y���G���rU˰7p�w�~~k�����#�[�J����߀���S��;�gۀ���I��O���B�ɣe�&��7��\�"��$0�?�@!�?���OJ��='�I�Sl���t�W0(݁�;nL� =@���X��Z9�|���4⓫9ZP"D*Ck
iF��e n� [�]x?[�GX���p*<��xϿ5�p~v����m���)���n��T����5�Y��q���2��Y��L�*��p:�� 4;�&�[|� @�(6�Lཽ��>,趴@��N�{=ܯ
�8�4�U�g&�e�}�D��W$�K����L;.�f�K�9���V� y��_N'��9ބ�]�
}��Ճ�O{�օ����C�#�<����`W�D�Ag����d[0�`j�`���XƱm�x)}1�� :=� �90\���S�C�wݾ�x��
|A\)���:�.�Pk�T���(ieh���ce4ӓX1�%�A����miT]���\'�����c�E��
��TD�ދ�ޱ� �7]��)xK���@P��e�k����)���˾��������80��j���tFd��ށ�˔�����/����'�q~ ����L��?H����=�F����ŏx�x��a^��$�d��~�Nމ����^j���Sx����r�⏸�b�8�����	L��[��sbX��������nI��� ����ߴ�sٰ��1�lL����&�i�u]OK��e!��	9��f3JZ�
�$|V5#'e󢦨����72ƿ���q������|:+��?;�+�|5�Z��e���~%w�\�zK��u���V�Z���ܹ�3�2�����>���V��%�c3wu�����I�_�-�'���'�Ui���]_�w�v�>uR����-�s��9�8{�=X��B��T��:��e=qi��F��i�]7��{��T2O��R�r�K��������5���Do)l��r����2��m������on���c��m������O,�A���8�&��p�s�a�?!���?��8�}5�}5�}59�ɛ^���6�R�!�/���8 n����X��E������m������lNb�?؜��]g9��V��BD�/��?�^�_}@�:t�����g{����t�8O�2�u^�ʽ�zú�??�8�:Q�&�NDE�?P�F�6����s�RE��i���k(���my�Y�����1��#�W��Es���F�:Wn���aa�������&�{Gՙй���.F����t���O��!KX�u����`V���I+˭�V䖶��'^[.V��r�r�oʳJ���r�(U�[�w݃��ǭV�D��aBn]�J3tK�yc�rS�g�F�P*�fuK��s��w����=��v�LK������U���Vf7�Z���

M�b&�.�z�Xz�)5�E�?_%��$}g�S�Z����Gb�mN2m�Y��Q����+y�JJ}�b�P�k��׏}��l'T�z=����a�?!������8 n��~�E�[,�����6�Q������`S�����"�g�������?���|�6�����A������-�l�o+�?;�cc��g�l0������?;�cs�1��5�\7�Čޕ���v�R���W󙜤t3|����Z^�
�$JFW�]ḀzVg��؂�/;�c����?ʍ�����U��z7��^99'�m�]j_��᳖J�����y���z�I~j�v2�w����U�������q�zo<���FM���t'g?��&�@t��(�(��Ƥq���͘�Χ�����?�
�`�������?;�c�����o��g�l6����-�-������������?l�;���q������l�o�?;�cs�9���r �������;������T)=��d^��MP\�w��/~q���O Y��Y�@�Cuvݑ;��F'�^ZM`�T���e��ߟ�ˉ��~�_�����H=�uQ�Ui�U;g������"7S��鴠?����s9��|T���e���*]�%���a�p<�|���V��*D�%E�I |7K��1�-%J��#�U���90�>�+�Mr��qE��ʕ۱zޘ���������
�l�YKU�u�ty\>�����y�<��wZ�+��ܯ���v���<��W{Å�0�{�irr,�����Hyh߶�n./z����թ]Q�5�1�k��z�Yӝ��\��L��PǏ����㇏����;�cs������.`������A���?6��������?��oX����Y�����S�k
	�^��������6�������;���o9����������8�����g��������3�Y�/xg��畬��MP�Е�����4C�
]]L4]�ji��2B�/�y��w��Qr�lVR�)�q��;�_��b����+��8��Ϊ������~}wu���g��T�������q���x>������?��V{3�d/״��NM�>�[�hv�x#��
ߺӆ3���lhO����ZM��W��������ٵ^��ѯ��@jΤ������f���oٺaU������>������uN�}=��"2��1�6��B6��v�k,����f[������?>������m��"��6��,���\�?�� 6L�3��q�/D������6���� 6L�3��i��"�?l�_,�-����s>_3݂������T�M�x]�
���]=�gҚ�u��t!��vUC)���
�o����+������{�_w��}[z�f�:��{��h�5�����ل?��dm���2��R��ޅ�XRM�dv%w����Çʳ�W:�Ѱ����F"�v=�P�������i#��g���μ�=1b���b��"�2wG���H�s�~��nIX�؜�f�31����j��T��ߚl�c��㤏m=.��.��}q:�����Je��?%���^��)������$�"������Ovp[�h���X2�v�+�?%���u������/��>&�V�A�s5�Kv
L�v^����/�ǻ(�84�r�V)�U�\���"*��Z���������R��;t/UYSq�)��vN�7��8�>���Z���Z�^(
�l��;q�V�<��vE��(��W���U�
;��O���yo��j\gVdH^���Z�O�!�~��u]�ק��i7ަ�-c۵\���P��X�C�ܫm$F$�=H$W��d���H'�Y�dʆ�v�����U.rW�T���G�v���9�nV7�\z��JYM�w��^g�i���]����*��Z�j��eǈ��A"�c__#A"��ܰ���L���V�j6l�|,Gj��En�?ʹ|�Ϋ�\��/��@��������-V?�R��$gΌI��I9"�L!�2rNH�g���ۚ�/�ӱc!6�N�_�Y����t�ko*�7���T�ҜP��O5�֨��Y1�j~��	R�A�|}�}R���V*��y��N����Zze�/x�+����g�'!���������>��2��O'����IG3����_�~�����-+�!q�P���k�v�q-�����Y8��њ��Y�-�Pn �}��|Z�C�d�»jA���6�]Y�Xtc�� (�!��t��V4RŹV�Ɗ�C�4�-�Ms:�X�;B�Y7�7�CT���s��(���yw������U"=k��Z�*�r��E��zi�� ��B��>�ݧ����}&Ju�f���ޠ>f;���b�j��־7K���b#���Ԭ2��n�B�RM}����<ߤ�j�$$[�dc�8����������t�_���O��ǣ�W����A�r
����w�?�s�;��u�t"�?���t����j)�������`��U�?�����Q�����[@�t�����?ف��t�?�v�+��w�t�x�'��%���S�d��#���������O*x��k����~R�d��X*���S��UF���SQ)�������&�X����҃�$EӢ�����-0?/�����'�
�������>����8�p+�j��*_�Jo�x�L?��2+�������?���>���n�F1Qj<�3M�J��3H�o��j��b�K.�v*z�GJ2"��\���.˥[+F<v���������fl��yiz	�k�*����;SSwױ����3��A��8�� �Ys]:ˢ32�g��C��d�I���m��lb(�����l$�h���4��f����D>�r0��Ĳ��I�R��0o�����D2�6W=���궜@KSI��X���5����,�����8�!�N��uˍ�-T�=�a����؈#X��x��p�Ʀ^)��tk|�}ޗtE�d�%�IM�h�͔թv/y3c�I=��^ ��߮��#!���{� [p�k�D�ǊO��,�J���L�����Ox�A�gQ(�(L�(�Y`�g�����Pʢ�C��C0����U��N�ct���	M�2�:�M�`�:�/��L���y�ȹ�d�_�)���fX�3�3�+l�A����E��EZŁ��Z(Oh��0�	��y��ϻ6"̇���AE�"ђ��>�p��TS&c�3F�A�����g�UK�U����B�.2
 ����U`7wY9`{����%���8&�^������r���\���d����
,�r�[g9�ڭ6JU���:p�*|��3����u�&�m�Ɵ|����r�p�)gh�R��{���5�4ch��@�=�7�77��g�`T
�� ��	V�z��p}��ZU�c����WA17wC:~�i�Y�b%�����g�v;2���b��V���܎JXȆ�uy�!�AK�F��{��"M�iƽ��}�Ȣ��[����(bbd([�I�����K����އ+r��Đ�1��Y.�.������Uz)�Z�$���d��"S�_�da9'jq��m�sn�.�i��ɹ7�Um��9d�$2Ah,�:P �h�M�L�����E��i!�U~i�h 	c��O,Y�%T&���6@��jI�@%$�B��5i_e�zw���?gxP�����1� {"���n��T��F�����|�Ŷ*5��n]���峤'� �K�z�k���k�����ϭk˘Hˏok �
�F�޺����x��E��1&jĶ�i�+�I�&b$�� ,g�Ǔ/��\���-	q��� ��|�^���L��/�q;">EK��4���pS;\�g�5��7#��d�:S]��B���2����~���'��b���^X.M4��"�A�p�@Sm�9ה,�|b��D�����}�eL���:,�"PR%k$��P Ʌ�+ �05��C�X8�Y�)�G����߰x�o�4�����nj�[׶�ח�D����|�� ��k�-0-&���#�����|��sjt~�4��X��8�S.�?<x;�'?	;�$3��u[&e��DV�6�̅��.�-�r���l)��Mi�~�0Ԝm��*;Ҫ��Kj�삇����,ԝG3�\����iG���d?HC��	ђ�g-�1��fU{U��S���?YE�Iy5a�%�pc�@��W�NU��4�իj��5a�;5Ვ�Pu�����$XR����v.����������x:X�?J��F��P,!Ք�h�Ey��N�%��7
P���sp�d�]��(��5� E,4!��l"�J.=��na�	K_ET0�f �H=��88���H�:�x� R�4��F��f�@Kk�0��`f�Zɳu����,)�V�4�ܕ�lo��\�B��3`h$	������Kdjk&FӗMː{ki���A�� 0b���U�3���_b$�*�2�^��qL�Uay��@-��V�Q�_E��;�R/\"	FK���n�@3e<�R�/IKM��,њ�$�Y����	ؒh���X邀�&�Q��hy,[�l]��(BQ!<��w�zOQ�d��@D�/6`�u���0X'y��o7o`.7�s�a�x0ý�t�����	��EB~olE/�Z�Y�^�r��*2���X��-�<Z4]цC�ڮt(YU��<�,<I���"=8�M�I������b����yL����!PQ��.P��9�^8�p�5E��a�0���z>ʃ	�n�uO�pq�cZ���D�����w���w���]�K�ckk�"C������$h�斨�^n͋�}�Ӟc��Øb406�6;a؀�!H&"i5
�,�;`,�;r��>1�� ���Vb��ܟ_��(�rp#d��3� Z��p��&6�R�n��Ţ�k'���<~r���fRP�4�2�6��X�� w��+��}� p`�0�}<��\�ڃ��Hd/�{��D|�S{n2@��6>�8.hK�A���8��8`"pX�|a#�[{��R�'�r���m�N!�QBY�U�������J 
�qc)
N���u�r�K�M�C-�zZ�� ��zYc���z+�	,M�z�=�ѸflL�`��7��D"�����g�L=٭�����s��]��0�A�(\6�3�6E��d�ɐ�j$��JúI�N �l1
����%���������I�cb���ve�r7HV��A�D�ru0Q���86�C��C����ʶg
�XR4���� �O�|y�t�.���ȳ�������kO��(o[w���������(b
�x�(o�mF��5��j������wtq��I�Ԏ)�9nT�̜��f�|Yd=��N�;�F�f*[���!=w�{ɨ.�@H���T�=lx	2i"�Ć��\t�uh�*w�FMN.��������].~{ik�ܿ�����)�& ��Ae��|�������l�h{��^K��ιC��$��)�=�K�Î�Y�^��W*�2N�Ç4�p*�U����iς:����`�=��O5���Id����,:d�c��C"�p�t&���.ft}d� �� �Z�U�I.m���cW��d&���������#�7���d5��E�A�l�5��l�>����SV�����&M�����)�[dK��a`_�p�4c��BS�8�ٯ�H�#��X:��[���]�����ѿ����VE���0~~4���6�
d1߻G`�����B�E#��1Q�RM�:�A��lj���-��``�g���!��<	���a2`�gV��œ�X��(���w�}�.Z��64���9�lBD�z��-��F:.}����b�'�w��yA�-�wո��Ć�?��-I0����[���L$��#�.��R��]��	�7q$��t��~/CO�)č�-7��6��3ro�[����1@���R�f�����+8gC���o���61܎�&R�UIP�I���:�����xb��O'���GI���َ��+��4�¬�%dm�Ԍ	��3�ٿ'��9�����-h�Ǹ=(|�w{D|/����wA��鑏��1O����
����h6�T�"�����K�D"�"˽�Ƿ��u������qO2��$q��_���>Qd�nc.EN���o�C<!d���թ��俳��(����vk�]�?�L���Ig��?GI�-�1j�xy�1k�5x���T����{�Q�`��Gl���س�+N�Ccd|�Cc���1�?*��6�R�
�j��1H���2<12^Po��z��V�^6D����F���2��l�x��Ю�t���$���������)x�����Ԅ���(��� ����j��8h�d��i�����/��?_���A��#����V�(�H�~T�o�/s��?��p��=���뿉T"����S]�]_>����l7���j�6��o:[1QL:��j�B�!�־\����/���e���u�O�GI���/��9��ز�qx��ܰ��d��ru�@���0���ᬨ��.�8�3�bK�+����"�	 k����#ԟo��5�^]�K�-�����^�7�����n�8�G-] ��""_��\)^*�� ������-	
��?�������,r�קAv쪐�}���$��ĽO��!����gڭF�m�yO��-a6EH��h%|�����M����5qî=3�'��ut���g�m���GpX��*���J�V��'Ƕ�k��>湻��k�"���	_"�Հ���T���w<�K7�=��=S��{��L��!�?/���e�d�������(����}gl���ħ��V����;
�{Y�#�~r7�7,̻�45ak�_H�b���B��]6�����gl��Uic��ˊ%�s���p��X�Pc�q�`�a�E�����R�h���Ho���D�-�	����U��i���_�����u�������vpٝ�E��J�,{5�؎�b�?�8N���APl�q�|8��8���HP�*-
R�+QڂXQ��"*H,-T���O<T$����Nror;���K�~�79��s��������s���?�3�_A.���\�������CO99��95��'�g�]��7R6[��#�D��92;֙ũuϤ��$S�i��K~�&A�gH$��h2$~��;��ȴ{���w:�u�����?�p�H�?����Gr�Pu��b���e��pl	IIғ�����D���~"�k2:���*���*�)���t��4ޖY-����6H<�Y�I7iLiUdN'�`��x���z�XZ������H0/��m"������"�Ɣ�?]큕f����Aӭ����9�tߞ��ކd�x�\�>F��Jݕj��PZ�����^���ʻ;�XbۮW�-slw��jH8���+(��f�LZ��d��;>NJ���]؎*-��.�ur;w;{�*yÛ�©��{r�î��8V�Cx��3�~������Y���qOl���za�?�z��\m�]�b�s��������c�x��tl��i���v�ɣ��X�6��M�Q�$.��Ӷ������M:�M�$A������vc�s�'~�>����7�����\���~����2��e�7.C�N����U�ޗ1bx�
=Y�����l� �/��}I����'�t �(Cו�����/_����&�{�N�s���}�	�n����������/'uO6��$Q����kI�ゴNv����M�K��3`�t<m�;?�����/��S�~��o�狽��7�˯�W"��������.���QB�3t"/Z%��y����9${J�sD�B���?啗�����7>��g���/_���̛���?�V�����*W���Aoi����K�/%X�7��Xq5��V��~������ �m[X/�6�1�3g:���-�"14�#�6�PĲ�<�99�"m�J$�9M����o���?�Ư?����o_���o��m�;�[��M��VX"����p)��������o�����c��_y~�����V~���s�w��ڜ�\*�
C��!\�(��dP
#%��}wR����;�]�$���ϲ	ml3lA���R]��uq�.�L�U=iI�{ծ��V��v��@[��*�'u�C���hi��WAsM�,_X�����v�&�ܷ�������@�vUT��ʔ�Z�E_Ci��*���|*�D)�i�`tI�ٸ�kKV��J��DAB��l�f� *�)i��s����*�����}�Y��%�){}sW��g�
�wxnb��~eP�Y��E	�3��<�X�5\������i�-���XC���sEz����[�G'��;(*ӊ�#��]����źX��2��	�P<�vժQ=��B#S}S��"ȥCl31Keb)}����t���Ʋ>�(WN?�r�1�%������,R�C��
 3"�[7�JE�^�$s�u�B�a�Ӛ-kd�3����u��r��LIa����� �Z��c�b�jA!ޫ�5m�c�D��,˔\�`�H���,]�;��c\!l	c v�5ڱ��wpj��� �*3����n�����#U��J�,��*N*�3�.YY��d�z��x���ڋ�>�xXuO��@e6f�3��P��/Ԕ��sp�P�0v��M�({#�G	xd+��R�[�`�l�d�Q��CL�0M�0w��bW�2�>�u�S{(�W��H����&R��Kg�\T��2��S���5�2X���SIF�V=#3Te&�b�ÜS͈�j�ڥX2D���O�nh��gLP�Y��F���?�pl^(7�d�\4�Z#Z��^�U�|��&�Ex�Y�H�F�ݞ��Nn9�;�J��U�4��/*@}�ȓ	l���2����<�SF�Cm��\�eT���\��j��Ȓ�t��X3/��"�SSzi��p�ft�lև݁@5*B7k��/h�Ѣ,���H}Q��}��F�	�(��a�~�YN���+��9��9&K��fNI6̠�E$��N�b����@�d�,�e���aq�ͩ2B����m ���ѩ�D�ڝ۝�{1�����ׂ�0K�?��RI���L��H����ų��)�L]�����R=�E��@g�����yu	�	��E,�j�L��2p\&r������ ����Ř]?V��G�ј�Z������l�X��Q�F΅�a�k�#��D�\sV*T�j����Q����@�$�x-1Q
���ll��X&ly,�����,3�*ף�����8n*E�1ˍb��js�7i���hvL	C�Iy��V��-���0�5m��jʒ�;8aW{���0��ȃ�qW2P�RuJ�T6�TdS~/K������%o�A�+P�@,$�%��-ť ���Ϊ�(G!�u��Z�rVl�f0�yS��p��ԂAp�J��9�J�ņB �cN�ö�̷�</�}�+��^�`��(��K�B�,�G�̬�M�m!�,�}n)��f8df����3�{�4��R(�D�'�7��Av����c�G|ރ�H�_������yݘ��w ǎ�M���O��pmǡN=�m'G>��:9��~z�����][�_��x��k�������^ðbY�:j<���8�����~ �{�<�������x?CtM��ڤ����CO�"�VK��A=?Q?6�#�u9�jhW�(S/��ˑ�N�rN��;�
�,���7$t�<
��U]�֡�1�(��4�|)�[>��F2�Ƽ��;Q+Xg��bb�����fUE�!ci�tc��b�5�(�ծV4�am�\�n�m6�6�`ۜ4}�2��9�4Q���e<3d���b��烁��E�d������b�Îk{��C�b�J�f*K[sM�է4�V�f�M�'i�V�Muc&V�N�t�A~��L;�hJc���-����fa��,��~8��s���b��3���p�����Q[^4��s>��bsn7��0���X*v�ܤN��v.�j��$��as2a�@\��U�K,�Bz�i:��\��(b�**e6�ꡐ��jӳ����7�>��E߅�E�b�3�3�-����������Y����ལ����XG��a��j����y��G�������n����7�?�	�����b�������D�&!9kyt�pZQ<T,)���n�[qsP�7���GY�Yw-�l<9F�a�7滨�X�Ehgh���6�x�K��X9mb4T�&Z�ހw���HQq�@f���]�AwHvGS���I��z!��Y�$�^2���2m�ǲ۳�[�8�b}nX����� ��>��"��R������y���ֱ��i1�vq�����`�� $�?6(JҊ����嬚�D-��w�`�R�R�-��K�X�W��h3S�J�Fb�����nWq��!=�;w��%0Y*uA�����B�\����X��6HU1��6-H�f��@\���>���b����ɰX�h<.�S��U���!�����=�%_�o��N����3^��;<ǕDz�f��A��5v� b�$Q^r�<H��Tf��
�,uTO�k�L�ʠ�j�N��L��+����-y)ٍ�4h B�
b�G�=�;\8�|V���R�H���&�n����������)�d7r沨���l��DN��M$z�tEV��;�7�,W����z,����w�6�l�;�Ī���DwE����8LSg����(S�q�`�d�Ls�����J����o�9.�U<_D�~ȢU�����_=��}!��2�]ہ`������m�����5��=��C��(���3ύ�����0�(SR��h��<ˍ�2��u��+V',��$��b�Z���.�dt���aiu<,C�2�lc�C�]m��{D�.�q�R�u�zI�]$>H::���H�T'x�.B�I?�\j�~�J��
�O�Q��Z�,U�x�kg=D;��.�=��y4�����ȃ��e_k�_WM92��r�T�������Ș$�� r>tʐޑk��fDl�G�X�����
web�(��'�.��;QƧ�v#{�7�?�z=�=�͟�>��h�����������OB��AgM#u1r�����Q���)�W��`m�[:�3��=����~y��W��i�M�S�`:�~�(�gǱ҃���8��Ks4?7Ne��M�s����i^�>��%�n���:��n�O���D��C��$D��1ߓ/~��Uی9177(���^�'������p�\��qLI�V�Z,�"$�%��9��R��|H�������Q0
F�(#	  x�|�  