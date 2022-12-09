//#include <cstdio>
#include <cstdlib>
//#include <cstring>
//#include <error.h>

using Guint = unsigned long;

enum JBIG2SegmentType {
  jbig2SegBitmap,
  jbig2SegSymbolDict,
  jbig2SegPatternDict,
  jbig2SegCodeTable
};

struct JBIG2Segment {
  JBIG2SegmentType getType() const { return jbig2SegCodeTable; }
};

struct JBIG2Bitmap {};

struct JBIG2SymbolDict {
  Guint getSize() const { return 1024; }
  JBIG2Bitmap *getBitmap(Guint index) {
    // avoid using `new`, so just return a null pointer for this proof-of-concept:
    // return new JBIG2Bitmap;
    return nullptr;
  }
};

struct GList {
  void append(void *elem) {}
  Guint getLength() { return 0; }
};

JBIG2Segment *findSegment(Guint refSeg) { return new JBIG2Segment; }

void *gmallocn(Guint nmemb, Guint size) { return calloc(nmemb, size); }

int getPos() { return 0; }

int errSyntaxError = 0;

void forcedentry_overflowable_alloc(Guint *refSegs, Guint nRefSegs) {
  JBIG2SymbolDict *symbolDict;
  JBIG2Segment *seg;
  JBIG2Bitmap **syms;
  GList *codeTables;
  Guint i, k, kk;
  Guint numSyms; // (1)

  // Keep codeTables on the stack to avoid requiring the standard library for `new`
  GList codeTablesStack;
  codeTables = &codeTablesStack;
  numSyms = 0;
  for (i = 0; i < nRefSegs; ++i) {
    if ((seg = findSegment(refSegs[i]))) {
      if (seg->getType() == jbig2SegSymbolDict) {
        numSyms += ((JBIG2SymbolDict *)seg)->getSize(); // (2)
      } else if (seg->getType() == jbig2SegCodeTable) {
        codeTables->append(seg);
      }
    } else {
      // error(errSyntaxError, getPos(),
      //       "Invalid segment reference in JBIG2 text region");
      // delete codeTables;
      return;
    }
  }

  // get the symbol bitmaps
  syms = (JBIG2Bitmap **)gmallocn(numSyms, sizeof(JBIG2Bitmap *)); // (3)
  kk = 0;
  for (i = 0; i < nRefSegs; ++i) {
    if ((seg = findSegment(refSegs[i]))) {
      if (seg->getType() == jbig2SegSymbolDict) {
        symbolDict = (JBIG2SymbolDict *)seg;
        for (k = 0; k < symbolDict->getSize(); ++k) {
          syms[kk++] = symbolDict->getBitmap(k); // (4)
        }
      }
    }
  }
}

int main(int argc, char **argv) {
//  if (argc != 1) {
//    printf("usage: ./prog < segment-count\n");
//    exit(1);
//  }
//  unsigned long seg_count;
//  scanf("%lu", &seg_count);
//  Guint *segments = new Guint[seg_count];
  Guint segments[420];
  forcedentry_overflowable_alloc(segments, 420);
//  delete[] segments;

  // HACK: Call exit(2) explicitly so that we don't fall off the end of the world.
  __asm__(
    "mov $1, %eax\n\t"
    "int $0x80\n\t"
  );

  return 0;
}
