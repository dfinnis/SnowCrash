git clone https://www.github.com/magnumripper/JohnTheRipper john
cd john/src
./configure LDFLAGS=-L$HOME/.brew/opt/openssl/lib CPPFLAGS=-I$HOME/.brew/opt/openssl/include
make -s clean && make -sj4
cd ../run
echo "42hDRfypTqqnw" > password
./john password
# cd ../../
# rm -rf john
