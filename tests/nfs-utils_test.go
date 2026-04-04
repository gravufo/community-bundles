package bundles_test

import (
	"os"

	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

var _ = Describe("nfs-utils bundle test", Label("nfs-utils"), func() {

	BeforeEach(func() {
		prepareBundle()
	})
	AfterEach(func() {
		cleanBundle()
	})

	It("installs NFS mount helpers in /usr/bin", func() {
		runBundle()

		for _, binary := range []string{
			"/usr/bin/mount.nfs",
			"/usr/bin/mount.nfs4",
		} {
			info, err := os.Stat(binary)
			Expect(err).ToNot(HaveOccurred(), "Expected %s to exist", binary)
			Expect(info.Mode() & 0111).ToNot(BeZero(), "Expected %s to be executable", binary)
		}
	})

})
