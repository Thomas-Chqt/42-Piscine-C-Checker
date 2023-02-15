EXO=

CC=cc

CFLAGS="-Wall -Wextra -Werror"

OUTPUT_DIR=Output
EXPECTED_OUTPUT_DIR=Expected_output/$EXO
MAIN_FILES_DIR=Main_files/$EXO

TEMP_DIR=Temp

REPO_DIR=repo

rm -r $OUTPUT_DIR

mkdir $OUTPUT_DIR

echo "Check Norme...\n"

norminette -R CheckForbiddenSourceHeader $REPO_DIR/*/*


echo "\nCompile and run..."

for nbr in 00 01 02 03 04 05 06 07 08 09 10 11 12
do
    mkdir $TEMP_DIR

	echo "\nCompile and run"$nbr"..."

	cp $REPO_DIR/ex$nbr/*  $TEMP_DIR
	cp $MAIN_FILES_DIR/*$nbr*  $TEMP_DIR

	cd $TEMP_DIR
	$CC $CFLAGS -c *.c
	cd ..

	$CC $CFLAGS -o $TEMP_DIR/Ex$nbr $TEMP_DIR/*.o

	./$TEMP_DIR/Ex$nbr

	./$TEMP_DIR/Ex$nbr > $OUTPUT_DIR/OutputEx$nbr


	rm -r $TEMP_DIR
done

echo "Compare output..."


for nbr in 00 01 02 03 04 05 06 07 08
do
	echo "\nCompare ex"$nbr"..."
	diff -U 3 $OUTPUT_DIR/OutputEx$nbr $EXPECTED_OUTPUT_DIR/OutputEx$nbr | cat -e
done
