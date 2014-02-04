if [ `uname` == Linux ]; then

    # This might be different in general. You can find the general location by
    # running ghci and running
    #   :m System.Directory
    #   getAppUserDataDirectory "cabal"
    # I couldn't figure out how to run this dynamically. ghci doesn't seem to have
    # a -c switch like python.
    export PATH="$HOME/.cabal/bin:$PATH"
    cabal install alex happy
    cabal install --only-dependencies
    cabal install hsb2hs  # a required build tool
    cabal install --flags="embed_data_files" citeproc-hs
    cabal configure --flags="embed_data_files"
    cabal build
    mkdir $PREFIX/bin
    cp $SRC_DIR/dist/build/pandoc/pandoc $PREFIX/bin/pandoc

fi

if [ `uname` == Darwin ]; then
    mkdir work
    cd work
    cpio -i -I ../Contents/Archive.pax.gz
    mkdir $PREFIX/bin
    cp usr/local/bin/* $PREFIX/bin/
fi
